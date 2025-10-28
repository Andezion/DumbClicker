import 'package:flutter/material.dart';
import 'package:game_new/ui/upgrade_screen.dart';
import 'dart:async';
import '../model/game_state.dart';
import '../model/upgrade.dart';
import '../service/save_service.dart';
import '../widgets/ects_button.dart';
import '../widgets/upgrade_card.dart';
import '../utils/formatters.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GameState gameState;
  Timer? autoClickTimer;
  Timer? saveTimer;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGameState();
  }

  Future<void> loadGameState() async {
    gameState = await SaveService.loadGame();
    setState(() {
      isLoading = false;
    });
    startAutoClick();
    startAutoSave();
  }

  void startAutoClick() {
    autoClickTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (gameState.ectsPerSecond > 0) {
            setState(() {
              gameState.ects += gameState.ectsPerSecond * 0.1;
            });
          }
        });
  }

  void startAutoSave() {
    saveTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      SaveService.saveGame(gameState);
    });
  }

  void onEctsClick() {
    setState(() {
      gameState.ects += gameState.ectsPerClick;
      gameState.totalEctsEarned++;
    });
  }

  void buyUpgrade(Upgrade upgrade) {
    final currentLevel = gameState.upgrades[upgrade.id] ?? 0;
    final price = upgrade.getPrice(currentLevel);

    if (gameState.ects >= price) {
      setState(() {
        gameState.ects -= price;
        gameState.upgrades[upgrade.id] = currentLevel + 1;

        switch (upgrade.type) {
          case UpgradeType.clickBoost:
            if (upgrade.id == 'laptop') {
              gameState.ectsPerClick += 0.1;
            } else if (upgrade.id == 'coffee') {
              gameState.ectsPerClick += 0.05;
            }
            break;
          case UpgradeType.autoClick:
            if (upgrade.id == 'friend') {
              gameState.ectsPerSecond += 0.5;
            } else if (upgrade.id == 'tutor') {
              gameState.ectsPerSecond += 2.0;
            }
            break;
          case UpgradeType.multiplier:
            gameState.ectsPerClick *= 1.1;
            gameState.ectsPerSecond *= 1.1;
            break;
        }
      });
      SaveService.saveGame(gameState);
    }
  }

  void prestige() {
    if (gameState.ects >= 30) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF2a2a4e),
          title: const Text('🎓 Następny Semestr?',
              style: TextStyle(color: Colors.white)),
          content: const Text(
            'Chcesz przejść na następny semestr?\n\n+1 Prestige Point\n+10% stały bonus do wszystkiego\n\nALE: stracisz wszystkie ECTS i apgrady!',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Nie, jeszcze poczekam',
                  style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  gameState.semester++;
                  gameState.prestigePoints++;
                  gameState.ects = 0;
                  gameState.ectsPerClick =
                      0.1 * (1 + gameState.prestigePoints * 0.1);
                  gameState.ectsPerSecond = 0;
                  gameState.upgrades = {
                    'laptop': 0,
                    'coffee': 0,
                    'friend': 0,
                    'tutor': 0,
                    'earlyPass': 0,
                  };
                });
                SaveService.saveGame(gameState);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('TAK! Zdać sesję! 🎓'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    autoClickTimer?.cancel();
    saveTimer?.cancel();
    SaveService.saveGame(gameState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 ECTS Clicker'),
        backgroundColor: const Color(0xFF0f3460),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatsScreen(gameState: gameState),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpgradesScreen(
                    gameState: gameState,
                    onUpgradeBuy: buyUpgrade,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildStatsCard(),
              const SizedBox(height: 20),
              EctsButton(
                onTap: onEctsClick,
                currentEcts: gameState.ects,
              ),
              const SizedBox(height: 20),
              _buildProgressBar(),
              const SizedBox(height: 20),
              _buildQuickUpgrades(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.purple.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ECTS Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text(
                    Formatters.formatEcts(gameState.ects),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Semestr ${gameState.semester}',
                      style: const TextStyle(color: Colors.white70)),
                  Text('Prestige: ${gameState.prestigePoints}',
                      style: const TextStyle(color: Colors.amber)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statItem('Per Click',
                  Formatters.formatPerClick(gameState.ectsPerClick)),
              _statItem('Per Second',
                  Formatters.formatPerSecond(gameState.ectsPerSecond)),
              _statItem('Total', '${gameState.totalEctsEarned}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildProgressBar() {
    double progress = (gameState.ects / 30).clamp(0.0, 1.0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Postęp do zaliczenia semestru',
                style: TextStyle(color: Colors.white70)),
            Text('${Formatters.formatEcts(gameState.ects)}/30 ECTS',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade800,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade400),
          minHeight: 15,
        ),
        const SizedBox(height: 15),
        if (gameState.ects >= 30)
          ElevatedButton.icon(
            onPressed: prestige,
            icon: const Icon(Icons.school),
            label: const Text('🎓 ZDAĆ SESJĘ I PRZEJŚĆ DALEJ!'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickUpgrades() {
    final upgrades = Upgrade.getAllUpgrades().take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '⚡ Quick Buy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpgradesScreen(
                      gameState: gameState,
                      onUpgradeBuy: buyUpgrade,
                    ),
                  ),
                ).then((_) => setState(() {}));
              },
              child: const Text('Zobacz więcej →'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...upgrades.map((upgrade) {
          return UpgradeCard(
            upgrade: upgrade,
            currentLevel: gameState.upgrades[upgrade.id] ?? 0,
            currentEcts: gameState.ects,
            onBuy: () => buyUpgrade(upgrade),
          );
        }).toList(),
      ],
    );
  }
}
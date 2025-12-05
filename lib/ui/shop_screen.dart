import 'package:flutter/material.dart';
import '../service/purchase_service.dart';
import '../model/game_state.dart';
import '../service/save_service.dart';
import 'achievements_screen.dart';

class ShopScreen extends StatefulWidget {
  final GameState gameState;

  const ShopScreen({super.key, required this.gameState});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    PurchaseService.setOnPurchaseSuccess((productId) {
      _handlePurchaseSuccess(productId);
    });
  }

  void _handlePurchaseSuccess(String productId) {
    setState(() {
      switch (productId) {
        case PurchaseService.premiumBattlePassId:
          widget.gameState.isPremiumBattlePass = true;
          _showSuccessDialog('👑 Premium Battle Pass активирован!');
          break;
        case PurchaseService.motivationBoostId:
          widget.gameState.tokens += 50;
          widget.gameState.motivation =
              (widget.gameState.motivation + 15).clamp(0, 100.0);
          _showSuccessDialog('☕ Dostałeś 50 tokens i +15% motywacji (max).');
          break;
        case PurchaseService.megaEctsPackId:
          widget.gameState.tokens += 1000;
          _showSuccessDialog(
              '💰 Dostałeś 1000 tokens (wymienialne ograniczenie).');
          break;
        case PurchaseService.removeAdsId:
          _showSuccessDialog('🚫 Реклама отключена!');
          break;
      }
      SaveService.saveGame(widget.gameState);
    });
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2a2a4e),
        title:
            const Text('✅ Zakup udany!', style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _buyProduct(String productId, bool isConsumable) async {
    setState(() {
      isLoading = true;
    });

    bool success;
    if (isConsumable) {
      success = await PurchaseService.buyConsumable(productId);
    } else {
      success = await PurchaseService.buyProduct(productId);
    }

    setState(() {
      isLoading = false;
    });

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Błąd zakupu. Spróbuj ponownie.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showExchangeDialog() {
    final maxAllowed = widget.gameState.maxEctsFromExchangePerSemester -
        widget.gameState.ectsExchangedThisSemester;
    final affordableByTokens = widget.gameState.tokens ~/ 100;
    final allowed =
        (maxAllowed < affordableByTokens) ? maxAllowed : affordableByTokens;

    if (allowed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Brak dostępnych wymian (brak tokens lub limit osiągnięty).')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a4e),
          title: const Text('Wymiana tokens na ECTS',
              style: TextStyle(color: Colors.white)),
          content: Text(
              'Możesz wymienić do $allowed ECTS (100 tokens = 1 ECTS). Masz ${widget.gameState.tokens} tokens.',
              style: const TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Anuluj')),
            ElevatedButton(
              onPressed: () {
                // exchange 1 ECTS
                _performExchange(1);
                Navigator.pop(context);
              },
              child: const Text('Wymień 1 ECTS'),
            ),
            ElevatedButton(
              onPressed: () {
                _performExchange(allowed);
                Navigator.pop(context);
              },
              child: Text('Wymień $allowed ECTS'),
            ),
          ],
        );
      },
    );
  }

  void _performExchange(int ectsToExchange) {
    // compute how many ECTS we can actually exchange now (limit + affordability)
    final remainingLimit = widget.gameState.maxEctsFromExchangePerSemester -
        widget.gameState.ectsExchangedThisSemester;
    final affordableByTokens = widget.gameState.tokens ~/ 100;
    final allowedByRequest = ectsToExchange;
    final allowed = [remainingLimit, affordableByTokens, allowedByRequest]
        .reduce((a, b) => a < b ? a : b);

    final cost = allowed * 100;
    if (widget.gameState.tokens < cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nie masz wystarczająco tokens.')),
      );
      return;
    }
    if (allowed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Osiągnięto limit wymiany na semestr.')),
      );
      return;
    }

    widget.gameState.tokens -= cost;
    widget.gameState.pendingEctsFromExchange += allowed;
    widget.gameState.ectsExchangedThisSemester += allowed;
    SaveService.saveGame(widget.gameState);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('Wymieniono $allowed ECTS (przyznane na koniec semestru).')),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💳 Sklep Premium'),
        backgroundColor: const Color(0xFF0f3460),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
              children: [
                _buildShopItem(
                  emoji: '👑',
                  title: 'Premium Battle Pass',
                  description: 'Odblokuj wszystkie nagrody + x2 boosty',
                  price: PurchaseService.getProductPrice(
                      PurchaseService.premiumBattlePassId),
                  productId: PurchaseService.premiumBattlePassId,
                  isConsumable: false,
                  isPurchased: widget.gameState.isPremiumBattlePass,
                ),
                _buildShopItem(
                  emoji: '☕',
                  title: 'Energy Pack',
                  description:
                      'Daje 50 tokens i przywraca do +15% motywacji (nie 100%).',
                  price: PurchaseService.getProductPrice(
                      PurchaseService.motivationBoostId),
                  productId: PurchaseService.motivationBoostId,
                  isConsumable: true,
                ),
                _buildShopItem(
                  emoji: '💰',
                  title: 'Token Bundle',
                  description:
                      'Dostań 1000 tokens (można wymienić z ograniczeniem).',
                  price: PurchaseService.getProductPrice(
                      PurchaseService.megaEctsPackId),
                  productId: PurchaseService.megaEctsPackId,
                  isConsumable: true,
                ),
                _buildShopItem(
                  emoji: '🚫',
                  title: 'Usuń Reklamy',
                  description: 'Graj bez reklam na zawsze!',
                  price: PurchaseService.getProductPrice(
                      PurchaseService.removeAdsId),
                  productId: PurchaseService.removeAdsId,
                  isConsumable: false,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    await PurchaseService.restorePurchases();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✅ Zakupy przywrócone!')),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Przywróć zakupy'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => _showExchangeDialog(),
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Wymień tokens → ECTS'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AchievementsScreen(gameState: widget.gameState)),
                    );
                  },
                  icon: const Icon(Icons.emoji_events),
                  label: const Text('Achievements'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildShopItem({
    required String emoji,
    required String title,
    required String description,
    required String price,
    required String productId,
    required bool isConsumable,
    bool isPurchased = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade800,
            Colors.indigo.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPurchased ? Colors.green : Colors.purple.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 50)),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (isPurchased)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  '✅ Zakupione',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            ElevatedButton(
              onPressed: () => _buyProduct(productId, isConsumable),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'KUP ZA $price',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

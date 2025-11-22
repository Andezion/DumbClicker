import 'package:flutter/material.dart';
import '../service/purchase_service.dart';
import '../model/game_state.dart';
import '../service/save_service.dart';

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
          widget.gameState.motivation = 100.0;
          _showSuccessDialog('☕ Motywacja восстановлена на 100%!');
          break;
        case PurchaseService.megaEctsPackId:
          widget.gameState.ects += 1000;
          _showSuccessDialog('💰 +1000 ECTS добавлено!');
          break;
        case PurchaseService.removeAdsId:
          // TODO: Disable ads
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
                  title: 'Motivation Boost Pack',
                  description: 'Przywróć 100% motywacji natychmiast!',
                  price: PurchaseService.getProductPrice(
                      PurchaseService.motivationBoostId),
                  productId: PurchaseService.motivationBoostId,
                  isConsumable: true,
                ),
                _buildShopItem(
                  emoji: '💰',
                  title: 'Mega ECTS Pack',
                  description: '+1000 ECTS natychmiast!',
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

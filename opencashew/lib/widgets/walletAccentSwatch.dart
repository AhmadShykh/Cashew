import 'package:budget/colors.dart';
import 'package:budget/database/tables.dart';
import 'package:budget/struct/wallet_accent_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Small circular swatch: optional wallet accent image, otherwise [colour].
class WalletAccentSwatch extends StatelessWidget {
  const WalletAccentSwatch({
    super.key,
    required this.wallet,
    required this.size,
    this.borderWidth = 0,
    this.borderColor,
  });

  final TransactionWallet wallet;
  final double size;
  final double borderWidth;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final Color fallback = HexColor(
      wallet.colour,
      defaultColor: Theme.of(context).colorScheme.primary,
    );

    if (!kIsWeb &&
        wallet.accentImageFileName != null &&
        wallet.accentImageFileName!.isNotEmpty) {
      return FutureBuilder<Uint8List?>(
        future: loadWalletAccentImageBytes(wallet.accentImageFileName),
        builder: (context, snapshot) {
          final bytes = snapshot.data;
          if (bytes != null && bytes.isNotEmpty) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: borderWidth > 0
                    ? Border.all(
                        color: borderColor ?? fallback.withOpacity(0.7),
                        width: borderWidth,
                      )
                    : null,
                image: DecorationImage(
                  image: MemoryImage(bytes),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          return _colorOnly(fallback);
        },
      );
    }

    return _colorOnly(fallback);
  }

  Widget _colorOnly(Color c) {
    final Color ring = borderColor ?? c.withOpacity(0.7);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: borderWidth > 0 ? Colors.transparent : c.withOpacity(0.7),
        border: borderWidth > 0
            ? Border.all(
                color: ring,
                width: borderWidth,
              )
            : null,
      ),
    );
  }
}

Color walletUiAccentColor(BuildContext context, TransactionWallet wallet) {
  return HexColor(
    wallet.colour,
    defaultColor: Theme.of(context).colorScheme.primary,
  );
}

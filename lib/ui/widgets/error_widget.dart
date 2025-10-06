import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi66/ui/helpers/utils/utils.dart';

class ErrorStateWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final String imagePath;
  final String? title;
  final String? description;
  final String? buttonText;
  final bool canRetry;


  const ErrorStateWidget({
    super.key,
    this.onRetry,
    this.imagePath = 'assets/images/error.png',
    this.title,
    this.description,
    this.buttonText,
    this.canRetry = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Image.asset(
                imagePath,
                fit: BoxFit.scaleDown,
              ),
            ),

            Text(
              title ?? 'Algo salió mal...',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
                  description ?? 'No pudimos cargar la información en este momento. '
                      'Verifica tu conexión o intenta nuevamente más tarde.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey[600]),
            ),

            if (canRetry)
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(
                buttonText ?? 'Reintentar',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ].separated(const SizedBox(height: 16)),
        ),
      ),
    );
  }
}

part of '../home.dart';

class HorizontalInstallGuide extends StatefulWidget {
  const HorizontalInstallGuide({super.key});

  @override
  State<HorizontalInstallGuide> createState() => _HorizontalInstallGuideState();
}

class _HorizontalInstallGuideState extends State<HorizontalInstallGuide> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<Map<String, dynamic>> _steps = [
    {
      "title": "Запуск файла",
      "desc": "Запустите установщик. Появится синее окно защиты Windows.",
      "icon": Icons.file_open_outlined,
      "isWarning": false,
    },
    {
      "title": "Нажмите «Подробнее»",
      "desc": "Кнопка «Выполнить» скрыта. Нажмите на текст «Подробнее» под заголовком.",
      "icon": Icons.info_outline,
      "isWarning": true,
    },
    {
      "title": "Выполнить в любом случае",
      "desc": "Теперь кнопка появилась. Нажмите её, чтобы начать установку.",
      "icon": Icons.check_circle_outline,
      "isWarning": false,
    },
  ];

  void _next() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }else if(_currentStep == _steps.length-1){
      _pageController.animateToPage(0,duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 200),
      child: SizedBox(
        width: 700,
        height: 700,
        child: Column(
          crossAxisAlignment: .center,
          children: [
            // 1. Верхний индикатор прогресса (Stepper Header)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: List.generate(_steps.length, (index) => Expanded(
                  child: Row(
                    children: [
                      _buildCircle(index, colors),
                      if (index < _steps.length - 1)
                        Expanded(child: Container(height: 2, color: index < _currentStep ? colors.primary : colors.surfaceContainerHighest)),
                    ],
                  ),
                )),
              ),
            ),

            // 2. Основной контент (PageView)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (i) => setState(() => _currentStep = i),
                itemBuilder: (context, index) => _buildStepCard(index, colors),
              ),
            ),

            // 3. Нижние кнопки управления
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _currentStep > 0 ? () => _pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut) : null,
                    child:  Text("Назад",style: TextStyle(color: colors.surface),),
                  ),
                  FilledButton.icon(
                    onPressed: _next,
                    icon: Icon(_currentStep < _steps.length - 1 ? Icons.arrow_forward : Icons.done),
                    label: Text(_currentStep < _steps.length - 1 ? "Далее" : "Понятно"),
                    style: FilledButton.styleFrom(backgroundColor: colors.inverseSurface),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(int index, ColorScheme colors) {
    bool isDone = index < _currentStep;
    bool isActive = index == _currentStep;
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? colors.primary : (isDone ? colors.primary : colors.surfaceContainerHighest),
      ),
      child: Center(
        child: isDone
            ? Icon(Icons.check, size: 18, color: colors.onPrimary)
            : Text("${index + 1}", style: TextStyle(color: isActive ? colors.onPrimary : colors.onSurfaceVariant, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStepCard(int index, ColorScheme colors) {
    final step = _steps[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(step['icon'], color: step['isWarning'] ? Colors.orange : colors.surface),
              const SizedBox(width: 12),
              Text(step['title'],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,color: colors.surface)),
            ],
          ),
          const SizedBox(height: 12),
          Text(step['desc'], style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: colors.surface.withValues(alpha: 0.5)
          )),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: step['isWarning'] ? Colors.orange.withOpacity(0.5) : colors.outlineVariant, width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  const Center(child: Icon(Icons.image, size: 64, color: Colors.grey)), // Заменить на Image.asset
                  if (step['isWarning'])
                    Positioned(
                      top: 20, right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, size: 16, color: Colors.orange.shade900),
                                const SizedBox(width: 8),
                                Text("ВАЖНЫЙ ШАГ!",
                                    style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,color: colors.surface)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Text("Это безопасно: мы просто еще не купили сертификат",
                                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic,color: colors.surface)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

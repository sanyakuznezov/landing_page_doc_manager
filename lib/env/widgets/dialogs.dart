

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Dialogs {



  static void showLicenseDialog(BuildContext context, {required VoidCallback onAccepted}) {
    bool isAccepted = false;
    const textLicence = "Внимание: Устанавливая, копируя или иным образом используя программное обеспечение «Паспортистсмарт» (далее — ПО), вы подтверждаете, что прочитали настоящие условия, понимаете их и соглашаетесь соблюдать их от имени Организации-пользователя.\n\n"
        "1. ПРЕДМЕТ СОГЛАШЕНИЯ\n"
        "Лицензиар предоставляет вам (далее — Лицензиат) простую (неисключительную) лицензию на использование ПО исключительно для автоматизации деятельности по учету и регистрации граждан в соответствии с действующим законодательством.\n\n"
        "2. ПЕРСОНАЛЬНЫЕ ДАННЫЕ И БЕЗОПАСНОСТЬ\n"
        "2.1. Локальная обработка: Лицензиат признает и подтверждает, что ПО осуществляет обработку и хранение персональных данных граждан (субъектов учета) исключительно в локальной среде на конечном устройстве Лицензиата.\n"
        "2.2. Отсутствие доступа: Лицензиар не имеет доступа к данным о гражданах, вводимым в ПО, и не несет ответственности за их сохранность, конфиденциальность или неправомерное использование третьими лицами на стороне Лицензиата.\n"
        "2.3. Гарантии Лицензиата: Лицензиат гарантирует, что является законным оператором персональных данных, имеет все разрешения и обеспечивает защиту рабочего места.\n\n"
        "3. СБОР ДАННЫХ ОБ ОРГАНИЗАЦИИ\n"
        "3.1. Для активации ПО Лицензиат предоставляет данные об организации (адрес, телефон, email).\n"
        "3.2. Данные хранятся в Firebase и используются для идентификации лицензии и автозаполнения реквизитов.\n\n"
        "4. ОГРАНИЧЕНИЯ\n"
        "Запрещается передавать учетные данные третьим лицам, декомпилировать код или использовать ПО после истечения срока лицензии.\n\n"
        "5. ОТВЕТСТВЕННОСТЬ\n"
        "5.1. ПО предоставляется «как есть» (as is).\n"
        "5.2. Лицензиар не несет ответственности за штрафы со стороны контролирующих органов.\n\n"
        "6. СРОК ДЕЙСТВИЯ\n"
        "Соглашение действует в течение неопределенного срока до следующего изменения лицензии.";

    showDialog(
      context: context,
      barrierDismissible: false, // Нельзя закрыть, кликнув мимо
      builder: (context) {
        return StatefulBuilder( // Для обновления состояния чекбокса внутри диалога
          builder: (context, setState) {

            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.gavel_rounded, color: Colors.blueAccent),
                  SizedBox(width: 12),
                  Expanded(child: Text('Лицензионное соглашение')),
                ],
              ),
              content: SizedBox(
                width: 500, // Фиксированная ширина для десктопа
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Область с текстом соглашения
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const SingleChildScrollView(
                        child: Text(
                          textLicence,
                          style: TextStyle(fontSize: 13, height: 1.4,color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Чекбокс подтверждения
                    CheckboxListTile(
                      value: isAccepted,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Я прочитал и принимаю условия соглашения',
                        style: TextStyle(fontSize: 13,),
                      ),
                      onChanged: (val) => setState(() => isAccepted = val!),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('ОТМЕНА', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  onPressed: isAccepted ? () {
                    Navigator.of(context).pop();
                    onAccepted();
                  } : null, // Кнопка активна только при галочке
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('ПРИНЯТЬ'),
                ),
              ],
            );
          },
        );
      },
    );
  }





  static void showSnackBar(BuildContext context,String title){
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text(title)));
  }


  static Future<void> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
    String textConfirm = 'Ок',
    String textCancel = 'Отмена',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
        },
              child: Text(textCancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(textConfirm),
            ),
          ],
        );
      },
    );
  }




}

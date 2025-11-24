import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_fusion/dart_fusion.dart';
import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

import '../../../env/env.dart';
import '../models/passportist_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSuccess = false;

  // Контроллеры для всех полей
  final fullNameCtrl = TextEditingController();
  final shortNameCtrl = TextEditingController();
  final unpCtrl = TextEditingController();
  final  codeFilialCtrl = TextEditingController();
  final legalAddressCtrl = TextEditingController();
  final postalAddressCtrl = TextEditingController();
  final ibanCtrl = TextEditingController();
  final bankNameCtrl = TextEditingController();
  final bankAddressCtrl = TextEditingController();
  final bicCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final accountantPhoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final accountantEmailCtrl = TextEditingController();
  final directorPositionCtrl = TextEditingController();
  final directorNameCtrl = TextEditingController();
  final directorAuthorityCtrl = TextEditingController();
  final contactPositionCtrl = TextEditingController();
  final contactNameCtrl = TextEditingController();
  final contactPhoneCtrl = TextEditingController();

  List<CardModel> _cards() {
    return [
      CardModel(
        source: 'assets/image/icon_inactive_features.svg',
        title: 'LKLKKLKKLKsad',
        subtitle: 'LL:KLKasdasdasda',
      ),
      CardModel(
        source: 'assets/image/icon_inactive_features.svg',
        title: 'LKLKKLKKLKsad',
        subtitle: 'LL:KLKasdasdasda',
      ),
      CardModel(
        source: 'assets/image/icon_inactive_features.svg',
        title: 'LKLKKLKKLKsad',
        subtitle: 'LL:KLKasdasdasda',
      ),
      CardModel(
        source: 'assets/image/icon_inactive_features.svg',
        title: 'LKLKKLKKLKsad',
        subtitle: 'LL:KLKasdasdasda',
      ),
    ];
  }

  static Widget textHeader() {
    return Builder(
      builder: (context) {
        return Seo.text(
          text: 'ПаспортистSmart',
          style: TextTagStyle.h1,
          child: Text(
            // Your logo
            'Заказ на приобретение и обслуживание программного обеспечения «ПаспортистSmart»',
            semanticsLabel: 'Order page',
            style: context.text.titleLarge?.copyWith(
              color: context.color.background,
              fontWeight: FontWeight.w900,
              fontSize: context.isDesktop ? 20.0 : 15,
            ),
          ),
        );
      },
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final order = PassportistOrder(
          fullName: fullNameCtrl.text,//*
          shortName: shortNameCtrl.text,//*
          unp: unpCtrl.text,//*
          legalAddress: legalAddressCtrl.text,//*
          postalAddress: postalAddressCtrl.text,//*
          iban: ibanCtrl.text,//*
          bankName: bankNameCtrl.text,//*
          bankAddress: bankAddressCtrl.text,
          bic: bicCtrl.text,//*
          phone: phoneCtrl.text,//*
          accountantPhone: accountantPhoneCtrl.text,//*
          email: emailCtrl.text,//*
          accountantEmail: accountantEmailCtrl.text,//*
          directorPosition: directorPositionCtrl.text,//*
          directorName: directorNameCtrl.text,//*
          directorAuthority: directorAuthorityCtrl.text,//*
          contactPosition: contactPositionCtrl.text,
          contactName: contactNameCtrl.text,
          contactPhone: contactPhoneCtrl.text,
          codeFilial: codeFilialCtrl.text,
        );

        final errors = validateRequiredFields(order);
        if(errors.isNotEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errors.join('\n'))),
          );
          return;
        }

        setState(() {
          _isLoading = true;
        });
        await  Future.delayed(const Duration(seconds: 2));
        final querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: emailCtrl.text)
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Пользователь с таким email уже существует!'),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }else{
          await FirebaseFirestore.instance
              .collection('users')
              .add(order.toMap());
          setState(() {
            _isSuccess = true;
          });
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
              const SnackBar(content: Text('Заказ успешно отправлен!')));
          return;
        }


      } on FirebaseException catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка отправки заказа: ${e.message}')),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Произошла непредвиденная ошибка: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<String> validateRequiredFields(PassportistOrder order) {
    final errors = <String>[];

    if (order.fullName.trim().isEmpty) {
      errors.add('Полное наименование обязательно для заполнения');
    }
    if (order.shortName.trim().isEmpty) {
      errors.add('Краткое наименование обязательно для заполнения');
    }
    if (order.unp.trim().isEmpty) {
      errors.add('УНП обязательно для заполнения');
    }
    if (order.legalAddress.trim().isEmpty) {
      errors.add('Юридический адрес обязателен для заполнения');
    }
    if (order.postalAddress.trim().isEmpty) {
      errors.add('Почтовый адрес обязателен для заполнения');
    }
    if (order.iban.trim().isEmpty) {
      errors.add('Счет (IBAN) обязателен для заполнения');
    }
    if (order.bankName.trim().isEmpty) {
      errors.add('Наименование банка обязательно для заполнения');
    }
    if (order.bic.trim().isEmpty) {
      errors.add('Код банка (BIC) обязателен для заполнения');
    }
    if (order.phone.trim().isEmpty) {
      errors.add('Контактный телефон обязателен для заполнения');
    }
    if (order.accountantPhone.trim().isEmpty) {
      errors.add('Телефон бухгалтерии обязателен для заполнения');
    }
    if (order.email.trim().isEmpty) {
      errors.add('Контактный e-mail обязателен для заполнения');
    }
    if (order.accountantEmail.trim().isEmpty) {
      errors.add('E-mail бухгалтерии обязателен для заполнения');
    }
    if (order.directorPosition.trim().isEmpty) {
      errors.add('Должность руководителя обязательна для заполнения');
    }
    if (order.directorName.trim().isEmpty) {
      errors.add('ФИО руководителя обязательно для заполнения');
    }
    if (order.directorAuthority.trim().isEmpty) {
      errors.add('Основание полномочий руководителя обязательно для заполнения');
    }

    return errors;
  }


  Widget buildField(String hint, TextEditingController ctrl,{bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DTextArea(
        isDense: false,
        textAlign: TextAlign.start,
        cursorColor: context.color.background,
        borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
        borderSideIdle: BorderSide.none,
        backgroundColor: context.color.onBackground.withAlpha(128),
        hintText: hint,
        prefixIcon: isRequired? Text('  *',style: TextStyle(fontSize: context.isDesktop?18:15),):null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Constants.spacing,
        ),
        textStyle: context.text.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: context.isDesktop?18:15,
          color: context.color.surface,
        ),
        hintStyle: context.text.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
            fontSize: context.isDesktop?18:15,
          color: context.color.surface.withAlpha(128),
        ),
        borderSideActive: BorderSide(
          color: context.color.background.withAlpha(191),
        ),
        controller: ctrl,

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return SelectionArea(
      child: Background.parallax(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.transparent,
            actions: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: isDesktop ? 50 : 10),
                  child: textHeader(),
                ),
              ),
              Builder(
                builder: (cont) {
                  return Semantics(
                    label: 'Back to Flutter Landing Page',
                    link: true,
                    child: Seo.link(
                      anchor: 'Back to Home',
                      href: '/',
                      child: DButton.text(
                        margin: const EdgeInsets.all(Constants.spacing),
                        onTap: () {
                          if(_isLoading){
                            return;
                          }
                          Env.controller.onTap(
                            cont,
                            id: Env.navigations.first.id,
                          );
                        },
                        text: 'На главную страницу',
                        borderRadius: BorderRadius.circular(
                          Constants.spacing * 0.5,
                        ),
                        splashColor: context.color.primary.withOpacity(0.1),
                        prefix: DImage(
                          source: 'assets/image/icon_active_home.svg',
                          size: const Size.square(Constants.spacing * 0.75),
                          color: context.color.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: _isLoading? Center(
            child: CircularProgressIndicator(color: context.color.background,),
          ):_isSuccess?Builder(
            builder: (context) {
              return SuccessOrderWidget(onClose: () => Env.controller.onTap(
                context,
                id: Env.navigations.first.id,
              ),);
            }
          ):isDesktop
              ? SingleChildScrollView(
            padding: const .symmetric(vertical:50,horizontal:50),
                  child: Row(
                    spacing: 50,
                    crossAxisAlignment: .start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          ...List.generate(_cards().length, (index) {
                            return _card(item: _cards()[index]);
                          }),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: _buildForm(),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildForm(),
                      ...List.generate(_cards().length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _card(item: _cards()[index]),
                        );
                      }),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildField('Полное наименование', fullNameCtrl,isRequired: true),
          buildField('Краткое наименование', shortNameCtrl,isRequired: true),
          buildField('УНП', unpCtrl,isRequired: true),
          buildField('Код филиала для ЭСЧФ', codeFilialCtrl),
          buildField('Юридический адрес', legalAddressCtrl,isRequired: true),
          buildField('Почтовый адрес', postalAddressCtrl,isRequired: true),
          buildField('Счет (IBAN)', ibanCtrl,isRequired: true),
          buildField('Наименование банка', bankNameCtrl,isRequired: true),
          buildField('Адрес банка', bankAddressCtrl),
          buildField('Код банка (BIC)', bicCtrl,isRequired: true),
          buildField('Контактный телефон', phoneCtrl,isRequired: true),
          buildField('Телефон бухгалтерии', accountantPhoneCtrl,isRequired: true),
          buildField('Контактный e-mail', emailCtrl,isRequired: true),
          buildField('E-mail бухгалтерии', accountantEmailCtrl,isRequired: true),
          buildField('Должность руководителя', directorPositionCtrl,isRequired: true),
          buildField('ФИО руководителя (полностью)', directorNameCtrl,isRequired: true),
          buildField('На основании чего действует', directorAuthorityCtrl,isRequired: true),
          buildField('Должность контактного лица', contactPositionCtrl),
          buildField('ФИО контактного лица', contactNameCtrl),
          buildField('Телефон контактного лица', contactPhoneCtrl),
          const SizedBox(height: 20),
          _isLoading
              ? const CircularProgressIndicator()
              : DButton.text(
                  margin: const EdgeInsets.all(Constants.spacing),
                  onTap: () => _submit(),
                  text: 'Отправить заказ',
                  borderRadius:
                      BorderRadius.circular(Constants.spacing * 0.5),
                  splashColor: context.color.primary.withAlpha(25),
                  prefix: Icon(
                    Icons.send,
                    color: context.color.primary.withOpacity(0.1),
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static Widget _card({required CardModel item}) {
    return Builder(
      builder: (context) {
        return Container(
          width: 300.0,
          height: 250.0,
          padding: const EdgeInsets.all(Constants.spacing),
          decoration: BoxDecoration(
            color: context.color.surface,
            borderRadius: BorderRadius.circular(Constants.spacing * 0.5),
            boxShadow: [
              BoxShadow(
                color: context.color.onBackground.withOpacity(0.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: MergeSemantics(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display item image
                Semantics(
                  image: true,
                  label: '${item.title} Icon',
                  child: Seo.image(
                    alt: '${item.title} Icon',
                    src: 'assets/${item.source}',
                    child: DImage(
                      source: item.source,
                      size: const Size.square(Constants.spacing * 1.5),
                      color: context.color.primary,
                    ),
                  ),
                ),

                // Add spacing between image and title
                Padding(
                  padding: const EdgeInsets.only(
                    top: Constants.spacing * 0.5,
                    bottom: Constants.spacing,
                  ),
                  child: Seo.text(
                    text: item.title,
                    style: TextTagStyle.h4,
                    child: Text(
                      item.title,
                      semanticsLabel: item.title,
                      style: context.text.bodyMedium?.copyWith(
                        color: context.color.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Display item subtitle
                Seo.text(
                  text: item.subtitle,
                  style: TextTagStyle.p,
                  child: Text(
                    item.subtitle,
                    semanticsLabel: item.subtitle,
                    textAlign: TextAlign.justify,
                    style: context.text.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



class SuccessOrderWidget extends StatelessWidget {
  final VoidCallback onClose;

  const SuccessOrderWidget({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        color: Colors.green.shade50,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green.shade600,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Заявка успешно отправлена!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Мы свяжемся с вами в ближайшее время.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.green.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Закрыть'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


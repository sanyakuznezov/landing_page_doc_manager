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

  // Контроллеры для всех полей
  final fullNameCtrl = TextEditingController();
  final shortNameCtrl = TextEditingController();
  final unpCtrl = TextEditingController();
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
      setState(() {
        _isLoading = true;
      });
      try {
        final order = PassportistOrder(
          fullName: fullNameCtrl.text,
          shortName: shortNameCtrl.text,
          unp: unpCtrl.text,
          legalAddress: legalAddressCtrl.text,
          postalAddress: postalAddressCtrl.text,
          iban: ibanCtrl.text,
          bankName: bankNameCtrl.text,
          bankAddress: bankAddressCtrl.text,
          bic: bicCtrl.text,
          phone: phoneCtrl.text,
          accountantPhone: accountantPhoneCtrl.text,
          email: emailCtrl.text,
          accountantEmail: accountantEmailCtrl.text,
          directorPosition: directorPositionCtrl.text,
          directorName: directorNameCtrl.text,
          directorAuthority: directorAuthorityCtrl.text,
          contactPosition: contactPositionCtrl.text,
          contactName: contactNameCtrl.text,
          contactPhone: contactPhoneCtrl.text,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .add(order.toMap());

        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
            const SnackBar(content: Text('Заказ успешно отправлен!')));
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

  Widget buildField(String hint, TextEditingController ctrl) {
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Constants.spacing,
        ),
        textStyle: context.text.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: context.color.surface,
        ),
        hintStyle: context.text.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
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
                builder: (context) {
                  return Semantics(
                    label: 'Back to Flutter Landing Page',
                    link: true,
                    child: Seo.link(
                      anchor: 'Back to Home',
                      href: '/',
                      child: DButton.text(
                        margin: const EdgeInsets.all(Constants.spacing),
                        onTap: () => Env.controller.onTap(
                          context,
                          id: Env.navigations.first.id,
                        ),
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
          body: isDesktop
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
          buildField('Полное наименование', fullNameCtrl),
          buildField('Краткое наименование', shortNameCtrl),
          buildField('УНП', unpCtrl),
          buildField('Юридический адрес', legalAddressCtrl),
          buildField('Почтовый адрес', postalAddressCtrl),
          buildField('Счет (IBAN)', ibanCtrl),
          buildField('Наименование банка', bankNameCtrl),
          buildField('Адрес банка', bankAddressCtrl),
          buildField('Код банка (BIC)', bicCtrl),
          buildField('Контактный телефон', phoneCtrl),
          buildField('Телефон бухгалтерии', accountantPhoneCtrl),
          buildField('Контактный e-mail', emailCtrl),
          buildField('E-mail бухгалтерии', accountantEmailCtrl),
          buildField('Должность руководителя', directorPositionCtrl),
          buildField('ФИО руководителя', directorNameCtrl),
          buildField('На основании чего действует', directorAuthorityCtrl),
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

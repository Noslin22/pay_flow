import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payflow_mobx/controllers/boleto_list_controller.dart';
import 'package:payflow_mobx/controllers/home_controller.dart';
import 'package:payflow_mobx/controllers/login_controller.dart';
import 'package:payflow_mobx/pages/extract_page.dart';
import 'package:payflow_mobx/pages/meus_boleto_page.dart';
import 'package:payflow_mobx/shared/models/user_model.dart';
import 'package:payflow_mobx/shared/theme.dart';
import 'package:payflow_mobx/shared/widgets/bottom_sheet/boleto_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserModel;
    final boletoController = BoletoController.boleto(email: args.email);
    final pages = [
      MeusBoletosPage(controller: boletoController),
      ExtractPage(
        email: args.email,
      ),
    ];
    List<String> names = args.name.split(' ');
    names.removeRange(2, names.length);
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            child: Container(
              color: AppColors.primary,
              height: 152,
              child: Center(
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: 'Olá, ',
                      style: TextStyles.titleRegular,
                      children: [
                        TextSpan(
                          text: names.join(' '),
                          style: TextStyles.titleBoldBackground,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    'Mantenha suas contas em dia',
                    style: TextStyles.captionShape,
                  ),
                  trailing: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      LoginController loginController = LoginController();
                      loginController.googleSignOut(context);
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        image: args.photoURL != null
                            ? DecorationImage(
                                image: Image.network(args.photoURL!).image,
                              )
                            : null,
                        color: args.photoURL != null ? null : Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(152),
          ),
          body: Observer(builder: (_) {
            return pages[controller.currentPage];
          }),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    controller.setPage(0);
                  },
                  icon: Observer(builder: (_) {
                    return Icon(
                      Icons.home,
                      color: controller.currentPage == 0
                          ? AppColors.primary
                          : AppColors.body,
                    );
                  }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/barcode_scanner',
                        arguments: boletoController);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.add_box_outlined,
                      color: AppColors.background,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.setPage(1);
                  },
                  icon: Observer(builder: (_) {
                    return Icon(
                      Icons.description_outlined,
                      color: controller.currentPage == 1
                          ? AppColors.primary
                          : AppColors.body,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: Observer(builder: (_) {
            if (boletoController.boleto.name != null) {
              return BoletoBottomSheet(
                model: boletoController.boleto,
                controller: boletoController,
              );
            } else {
              return Container(
                width: 0,
                height: 0,
                color: Colors.transparent,
              );
            }
          }),
        )
      ],
    );
  }
}

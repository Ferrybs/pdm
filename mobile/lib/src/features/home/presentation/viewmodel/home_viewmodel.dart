import 'package:basearch/src/features/home/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/home/domain/model/chart_serie.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:localization/localization.dart';
import '../../domain/usecase/home_usecase.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final _usecase = Modular.get<HomeUseCase>();

  @observable
  String? clientName;

  @observable
  List<PlantStatsModel> plantList = [];

  @action
  void updateClientName(String name) {
    clientName = name;
  }

  getClientName() async {
    String? name = await _usecase.getUserName();
    if (name != null) {
      updateClientName(name);
    }
  }

  String gethomeTittle() {
    if (clientName != null) {
      return clientName! + ", " + "home-tittle".i18n();
    } else {
      return "error-home-tittle".i18n();
    }
  }

  void navigateToLogin() {
    Modular.to.navigate("/auth/");
  }

  void navigateToMap() {
    Modular.to.navigate('/map/');
  }
}

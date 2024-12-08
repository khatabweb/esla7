// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:esla7/Screens/CommonScreen/CitiesDropDown/data/cubit/cities_dropdown_cubit.dart';
import 'package:esla7/Screens/CommonScreen/Slider/data/cubit/slider_cubit.dart';
import 'package:esla7/Screens/Provider/Create_Ad/Ad_features_terms/data/cubit/ad_features_terms_cubit.dart';
import 'package:esla7/Screens/Provider/ProviderMainPage/Notification/data/cubit/owner_notification_cubit.dart';
import 'package:esla7/Screens/Provider/ProviderProfile/Profile/data/cubit/owner_profile_cubit.dart';
import 'package:esla7/Screens/User/BankAccounts/data/cubit/bank_account_cubit.dart';
import 'package:esla7/Screens/User/MainPage/Home/main_services/data/cubit/our_services_cubit.dart';
import 'package:esla7/Screens/User/MainPage/Notification/data/cubit/user_notification_cubit.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/CurrentOrders/data/cubit/user_current_cubit.dart';
import 'package:esla7/Screens/User/MainPage/UserOrders/FinishedOrders/data/cubit/user_finished_cubit.dart';
import 'package:esla7/Screens/User/MainPage/allChats/data/cubit/allchats_cubit.dart';
import 'package:esla7/Screens/User/MainPage/chat/data/cubit/chat_cubit.dart';
import 'package:esla7/Screens/User/Profile/ProfileView/data/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../CommonScreen/DrawerPages/Views/Complaints_and_suggestions/Bloc/cubit.dart';
import '../../Provider/Auth/ConfirmCode/bloc/cubit.dart';
import '../../Provider/Auth/ForgetPassword/bloc/cubit.dart';
import '../../Provider/Auth/Login/bloc/cubit.dart';
import '../../Provider/Auth/SetNewPassword/bloc/cubit.dart';
import '../../Provider/Auth/SignUp/bloc/cubit.dart';
import '../../Provider/Create_Ad/CreateAdsForm/Ads_Subscripe_bloc/cubit.dart';
import '../../Provider/ProviderMainPage/ProviderOrders/OrderDetails/bloc/cubit.dart';
import '../../Provider/ProviderMainPage/ProviderOrders/OrderDetails/buttons_bloc/data/accept/cubit.dart';
import '../../Provider/ProviderMainPage/ProviderOrders/OrderDetails/buttons_bloc/data/refuse/cubit.dart';
import '../../Provider/ProviderProfile/EditProfile/data/bloc/cubit.dart';
import '../../Provider/provider_Services/Add_Service/AddService/bloc/cubit.dart';
import '../../Provider/provider_Services/Add_Service/Service_Name_List/bloc/cubit.dart';
import '../../Provider/provider_Services/Add_Service/Sub_Service_List/bloc/cubit.dart';
import '../../Provider/provider_Services/DialogsWidgets/delete_bloc/cubit.dart';
import '../../Provider/provider_Services/Services/bloc/endList/cubit.dart';
import '../../Provider/provider_Services/Services/bloc/subList/cubit.dart';
import '../../User/Auth/ConfirmCode/Bloc/cubit.dart';
import '../../User/Auth/ForgetPassword/Bloc/cubit.dart';
import '../../User/Auth/Login/Bloc/cubit.dart';
import '../../User/Auth/SetNewPassword/data/Bloc/cubit.dart';
import '../../User/Auth/SignUp/Bloc/cubit.dart';
import '../../User/Cart/bloc/cubit.dart';
import '../../User/CheckOut/data/bloc/cubit.dart';
import '../../User/MainPage/UserOrders/OrderDetails/data/bloc/cubit.dart';
import '../../User/MainPage/UserOrders/OrderDetails/rate/data/bloc/cubit.dart';
import '../../User/Profile/EditProfile/data/bloc/cubit.dart';
import '../../User/ProviderProfile/EndService/bloc/cubit.dart';
import '../../User/ProviderProfile/OwnerDetails/data/Bloc/cubit.dart';
import '../../User/ProviderProfile/SubService/bloc/cubit.dart';
import '../../User/Search/data/bloc/cubit.dart';
import '../../User/SingleSection/owner_bloc/cubit.dart';

abstract class BlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider<SignUpCubit>(create: (_) => SignUpCubit()),
    BlocProvider<ConfirmCodeCubit>(create: (_) => ConfirmCodeCubit()),
    BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
    BlocProvider<ComplaintsCubit>(create: (_) => ComplaintsCubit()),
    BlocProvider<UserResetCubit>(create: (_) => UserResetCubit()),
    BlocProvider<UpdatePasswordCubit>(create: (_) => UpdatePasswordCubit()),
    BlocProvider<OwnerDetailsCubit>(create: (_) => OwnerDetailsCubit()),
    BlocProvider<UserUpdateCubit>(create: (_) => UserUpdateCubit()),
    BlocProvider<UserOrderDetailsCubit>(create: (_) => UserOrderDetailsCubit()),
    BlocProvider<RateCubit>(create: (_) => RateCubit()),
    BlocProvider<UserSubListCubit>(create: (_) => UserSubListCubit()),
    BlocProvider<UserEndListCubit>(create: (_) => UserEndListCubit()),
    BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
    BlocProvider<CartCubit>(create: (_) => CartCubit()),
    BlocProvider<CheckoutCubit>(create: (_) => CheckoutCubit()),
    BlocProvider<OwnersCubit>(create: (_) => OwnersCubit()),
    BlocProvider<SliderCubit>(create: (_) => SliderCubit()),
    BlocProvider<OurServicesCubit>(create: (_) => OurServicesCubit()),
    BlocProvider<UserNotificationCubit>(create: (_) => UserNotificationCubit()),
    BlocProvider<AllChatsCubit>(create: (_) => AllChatsCubit()),
    BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
    BlocProvider<BankAccountCubit>(create: (_) => BankAccountCubit()),
    BlocProvider<ChatCubit>(create: (_) => ChatCubit()),
    BlocProvider<UserCurrentCubit>(create: (_) => UserCurrentCubit()),
    BlocProvider<UserFinishedCubit>(create: (_) => UserFinishedCubit()),
    BlocProvider<CitiesDropdownCubit>(create: (_) => CitiesDropdownCubit()),

    ///provider bloc
    BlocProvider<OwnerSignUpCubit>(create: (_) => OwnerSignUpCubit()),
    BlocProvider<OwnerVerifyCubit>(create: (_) => OwnerVerifyCubit()),
    BlocProvider<OwnerLoginCubit>(create: (_) => OwnerLoginCubit()),
    BlocProvider<OwnerResetCubit>(create: (_) => OwnerResetCubit()),
    BlocProvider<OwnerUpdatePassCubit>(create: (_) => OwnerUpdatePassCubit()),
    BlocProvider<SubServiceCubit>(create: (_) => SubServiceCubit()),
    BlocProvider<ServiceNameCubit>(create: (_) => ServiceNameCubit()),
    BlocProvider<AddServiceCubit>(create: (_) => AddServiceCubit()),
    BlocProvider<OwnerOrderDetailsCubit>(
        create: (_) => OwnerOrderDetailsCubit()),
    BlocProvider<AcceptCubit>(create: (_) => AcceptCubit()),
    BlocProvider<RefuseCubit>(create: (_) => RefuseCubit()),
    BlocProvider<SubServiceListCubit>(create: (_) => SubServiceListCubit()),
    BlocProvider<EndServiceListCubit>(create: (_) => EndServiceListCubit()),
    BlocProvider<AdsSubscribeCubit>(create: (_) => AdsSubscribeCubit()),
    BlocProvider<OwnerUpdateCubit>(create: (_) => OwnerUpdateCubit()),
    BlocProvider<DeleteServiceCubit>(create: (_) => DeleteServiceCubit()),
    BlocProvider<AdFeaturesTermsCubit>(create: (_) => AdFeaturesTermsCubit()),
    BlocProvider<OwnerNotificationCubit>(create: (_) => OwnerNotificationCubit()),
    BlocProvider<OwnerProfileCubit>(create: (_) => OwnerProfileCubit()),
  ];
}

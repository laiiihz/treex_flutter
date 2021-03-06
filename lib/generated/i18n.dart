import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get about => "About";
  String get add_user => "Add User";
  String get agree_and_continue => "Agree and Continue";
  String get auto => "AUTO";
  String get cancel => "CANCEL";
  String get cloud_files => "CLOUD FILES";
  String get confirm => "CONFIRM";
  String get connect_fail => "CONNECT FAIL";
  String get connect_success => "CONNECT SUCCESS";
  String get create => "CREATE";
  String get create_a_account => "Create a Account";
  String get create_a_account_if_you_dont_have => "Create a Account if you don't have";
  String get create_time => "Create Time";
  String get developer_mode => "Developer Mode";
  String get file_type => "File Type";
  String get folder_name_cant_be_empty => "Folder name can't be empty";
  String get home => "HOME";
  String get ip_address => "IP address";
  String get length => "Length";
  String get licences => "licences";
  String get licenses => "licenses";
  String get local_files => "LOCAL FILES";
  String get log_out => "LOG OUT";
  String get loginin_on_signup => "LOGININ ON SIGNUP";
  String get me => "Me";
  String get mode => "Mode";
  String get network_settings => "Network Settings";
  String get new_folder => "NEW FOLDER";
  String get next => "NEXT";
  String get night_mode => "NIGHT MODE";
  String get off => "OFF";
  String get on => "ON";
  String get password => "YOUR PASSWORD";
  String get password_cant_be_empty => "PASSWORD CANT BE EMPTY";
  String get password_is_not_same => "Password is not same";
  String get path => "Path";
  String get phone_number => "Phone Number";
  String get photos => "PHOTOS";
  String get port => "Port";
  String get reenter_your_password => "Re-enter your password";
  String get save => "SAVE";
  String get set_an_avatar => "Avatar";
  String get settings => "SETTINGS";
  String get share => "Share";
  String get share_folder => "Share Folder";
  String get shared => "Shared";
  String get short_password => "PASSWORD";
  String get sign_up => "Sign Up";
  String get sign_up_sign_in => "SIGN UP/SIGN IN";
  String get tree => "Tree";
  String get user_agreement => "User Agreement";
  String get user_name => "User Name";
  String get user_name_cant_empty => "User Name can't be Empty";
  String get user_prefix => "user:";
  String get user_settings => "User Settings";
  String get x => "x";
}

class $en extends S {
  const $en();
}

class $zh extends S {
  const $zh();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get cancel => "取消";
  @override
  String get auto => "自动";
  @override
  String get user_agreement => "用户使用协议";
  @override
  String get about => "关于";
  @override
  String get password_is_not_same => "密码不一致";
  @override
  String get network_settings => "网络设置";
  @override
  String get local_files => "本地";
  @override
  String get photos => "相册";
  @override
  String get short_password => "密码";
  @override
  String get developer_mode => "开发模式";
  @override
  String get mode => "模式";
  @override
  String get user_settings => "用户设置";
  @override
  String get path => "路径";
  @override
  String get password => "输入您的密码 ";
  @override
  String get file_type => "文件类型";
  @override
  String get me => "我";
  @override
  String get create => "创建";
  @override
  String get user_name_cant_empty => "用户名不能为空1";
  @override
  String get password_cant_be_empty => "密码不能为空";
  @override
  String get connect_success => "连接成功";
  @override
  String get settings => "设置";
  @override
  String get create_time => "创建时间";
  @override
  String get sign_up => "注册";
  @override
  String get tree => "Tree";
  @override
  String get set_an_avatar => "头像";
  @override
  String get loginin_on_signup => "登录或注册 ";
  @override
  String get log_out => "退出登录";
  @override
  String get cloud_files => "云盘";
  @override
  String get port => "端口号";
  @override
  String get phone_number => "Phone Number";
  @override
  String get next => "下一步";
  @override
  String get shared => "共享";
  @override
  String get create_a_account => "创建一个新账户";
  @override
  String get user_name => "用户名";
  @override
  String get save => "保存";
  @override
  String get night_mode => "夜间模式";
  @override
  String get user_prefix => "用户:";
  @override
  String get share => "分享";
  @override
  String get connect_fail => "连接失败";
  @override
  String get folder_name_cant_be_empty => "文件夹名称不能为空";
  @override
  String get agree_and_continue => "同意并继续";
  @override
  String get licences => "licences";
  @override
  String get on => "开启";
  @override
  String get create_a_account_if_you_dont_have => "若无账户将创建账户";
  @override
  String get length => "大小";
  @override
  String get reenter_your_password => "重新输入您的密码";
  @override
  String get share_folder => "共享";
  @override
  String get new_folder => "新建文件夹";
  @override
  String get ip_address => "IP 地址";
  @override
  String get off => "关闭";
  @override
  String get home => "主页";
  @override
  String get confirm => "确定";
  @override
  String get licenses => "licenses";
  @override
  String get x => "x";
  @override
  String get sign_up_sign_in => "登录/注册";
  @override
  String get add_user => "添加用户";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("zh", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "zh":
          S.current = const $zh();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();

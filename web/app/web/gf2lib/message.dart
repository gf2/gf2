part of gf2lib;

class Messages {
  static get(id) {
    var lang = getDisplayLang();
    return _MESSAGES[id][lang];
  }
  
  static final Map SUPPORTED_LANGUAGES = {"en": true, "ch": true};
  
  static final _MESSAGES = {
    "TITLE": {"en": "(GF)^2", "ch": "功夫2"},
    "HELLO": {"en": "Hello to (GF)^2", "ch": "欢迎"},
    "HOME": {"en": "Home", "ch": "首页"},
    "ABOUT": {"en": "About", "ch": "关于"},
    "CONTACT": {"en": "Contact", "ch": "联系方式"},
    "SELECT_LANGUAGE": {"en": "Language", "ch": "语言"},
    "LOGIN": {"en": "Login", "ch": "登陆"}
  };
  
  static getDisplayLang() {
    if (displayLanguage == '') {
      if (window.localStorage.containsKey(LOCAL_STORAGE_DISPLAY_LANGUAGE)) {
        displayLanguage = window.localStorage[LOCAL_STORAGE_DISPLAY_LANGUAGE];
      } else {
        // Default to local setting;
        String lang = window.navigator.language; 
        // Slice "en-US"
        lang = lang.slice(0, 2);
        if (!SUPPORTED_LANGUAGES.containsKey(lang)) {
          lang = 'en';
        }
        displayLanguage = lang;
      }
    }
    return displayLanguage;
  }
  
  static setLanguage() {
    window.localStorage[LOCAL_STORAGE_DISPLAY_LANGUAGE] = displayLanguage;
  }
  
  // Binds with UI.
  static String displayLanguage = '';
  
  static String LOCAL_STORAGE_DISPLAY_LANGUAGE = "DISPLAY_LANGUAGE";
}

enum Environement {DEV,STAGING, PROD}

class Constanante {
  static Map<String, dynamic> _config;
  static void setEnvironement(Environement environement){
    switch(environement){
      case Environement.DEV:
        _config = _Config.devConstants;
        break;
      case Environement.PROD:
        _config = _Config.prodConstants;
        break;
      case Environement.STAGING:
        _config = _Config.stagingConstants;
        break;
    }
  }
  
  static dynamic get wereAmIURL => _config[_Config.WERE_AM_I];
  static bool get isDebuggable => _config[_Config.IS_DEBUGGABLE];

}

mixin _Config {
  static const WERE_AM_I = 'WERE_AM_I';
  static const IS_DEBUGGABLE = 'IS_DEBUGGABLE';


  static Map<String, dynamic> devConstants = {
    WERE_AM_I: 'DEV',
    IS_DEBUGGABLE: true
  };
  static Map<String, dynamic> stagingConstants = {
    WERE_AM_I: 'STAGING',
    IS_DEBUGGABLE: true
  };
  static Map<String, dynamic> prodConstants = {
    WERE_AM_I: 'PROD',
    IS_DEBUGGABLE: false
  };


}
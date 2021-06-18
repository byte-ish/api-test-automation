function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
   config.userEmail = 'ish@ish.com'
   config.userPass = '12345678'
  } else if (env == 'qa') {
    // customize
  }

  //Add Auth Token at Golbal Level
  var accessToken = karate.callSingle('classpath:src/test/java/com/learn/karate/helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token '+accessToken})

  return config;
}
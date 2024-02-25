package com.iconx;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueResponse;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import org.json.JSONObject;

public class SecretManager {
   String key;
   String value;
    Region region = Region.of("us-east-1");
    GetSecretValueResponse getSecretValueResponse;
    SecretsManagerClient client;
    GetSecretValueRequest getSecretValueRequest;

public SecretManager (){
    getSecretKeyValuePairFromContextFile();
   
      client = SecretsManagerClient.builder()
            .region(region)
            .build();
   
}
private void getSecretKeyValuePairFromContextFile(){
try{
Context context = new InitialContext();
Context envContext = (Context) context.lookup("java:/comp/env");
key  = (String) envContext.lookup("key");
value  = (String) envContext.lookup("value");

    }catch (NamingException e){
     System.out.println(e.toString());
    }
  
 }

    public String showSecret() {
        getSecretValueRequest = GetSecretValueRequest.builder()
            .secretId(key)
            .build();
             getSecretValueResponse = client.getSecretValue(getSecretValueRequest);
             String secret = getSecretValueResponse.secretString();
             System.out.println(secret);
         
                return secret; 

    }

   
}

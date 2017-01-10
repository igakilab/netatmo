import com.mongodb.*;
import com.mongodb.annotations.*;
import com.mongodb.assertions.*;
import com.mongodb.async.*;
import com.mongodb.binding.*;
import com.mongodb.bulk.*;
import com.mongodb.client.*;
import com.mongodb.client.gridfs.*;
import com.mongodb.client.gridfs.codecs.*;
import com.mongodb.client.gridfs.model.*;
import com.mongodb.client.model.*;
import com.mongodb.client.model.geojson.*;
import com.mongodb.client.model.geojson.codecs.*;
import com.mongodb.client.result.*;
import com.mongodb.connection.*;
import com.mongodb.connection.netty.*;
import com.mongodb.diagnostics.logging.*;
import com.mongodb.event.*;
import com.mongodb.gridfs.*;
import com.mongodb.internal.*;
import com.mongodb.internal.async.*;
import com.mongodb.internal.authentication.*;
import com.mongodb.internal.connection.*;
import com.mongodb.internal.management.jmx.*;
import com.mongodb.internal.thread.*;
import com.mongodb.internal.validator.*;
import com.mongodb.management.*;
import com.mongodb.operation.*;
import com.mongodb.selector.*;
import com.mongodb.util.*;
import org.bson.*;
import org.bson.assertions.*;
import org.bson.codecs.*;
import org.bson.codecs.configuration.*;
import org.bson.conversions.*;
import org.bson.diagnostics.*;
import org.bson.io.*;
import org.bson.json.*;
import org.bson.types.*;
import org.bson.util.*;

MongoClient mongo;
MongoCollection<Document> collection;

FindIterable<Document> result;
float n;
Document[] docs = new Document[5];
Document latest;
int fnct;


void setup() {
  
        //MongoDBサーバーに接続
      mongo = new MongoClient("150.89.234.253", 27018);
      //利用するデータベースを取得
      MongoDatabase database = mongo.getDatabase("test");
      //利用するコレクション名(テーブル)を指定
      collection = database.getCollection("netatmotest");
  
      for(Document doc : collection.find()){
        System.out.println(doc.toJson());
      }
      
  size(1000, 600);
  background(100);
  fill(0);
  result = collection.find().sort(Sorts.descending("date"));
  latest = result.first();
  
  //String t = null;
  Float tem = 0.0;
  Integer Humidity = 0;
  Integer CO2 = 0;
  Integer Noise = 0;
  Float Pressure = 0.0;
  

// String t = h + ":" + nf(m, 2) + ":" + nf(s, 2);
  
  
  for(Document doc : result){
    System.out.println(doc); 
    
    tem = latest.getDouble("tem").floatValue();
     Humidity = latest.getInteger("Humidity");
     CO2 = latest.getInteger("CO2");
     Noise = latest.getInteger("Noise");
     Pressure = latest.getDouble("Pressure").floatValue();
  }
  
  textSize(20);
  //text("time :"+t, 600, 75);
  text("temperature : "+tem + "℃", 600,100);
  text("Humidity : " + Humidity + "%", 600,125);
  text("CO2 : " + CO2 + "ppm", 600,150);     
  text("Noise : " + Noise + "dB", 600,175);     
  text("Pressure : " +Pressure + "mb", 600,200);
  
  fnct = 0;
}

void draw(){
  
 int cnt = 0;
 int s = second();
 int m = minute();
 int h = hour();  
 String t = null;
 t = h + ":" + nf(m, 2) + ":" + nf(s, 2);
 text("time :"+t, 600, 75);
 
 if(cnt <= 1){
 fill(100);
 //noStroke();
 rect(590,50,160,30);
 
 fill(0);
 text("time :"+t, 600, 75);
 }
 cnt++;
 
fnct++;
if(fnct >= 18000){
  size(1000, 600);
  background(100);
  fill(0);
  result = collection.find().sort(Sorts.descending("date"));
  latest = result.first();
  
  Float tem = 0.0;
  Integer Humidity = 0;
  Integer CO2 = 0;
  Integer Noise = 0;
  Float Pressure = 0.0;
  
  for(Document doc : result){
    System.out.println(doc); 
    tem = latest.getDouble("tem").floatValue();
     Humidity = latest.getInteger("Humidity");
     CO2 = latest.getInteger("CO2");
     Noise = latest.getInteger("Noise");
     Pressure = latest.getDouble("Pressure").floatValue();
  }
  textSize(20);
  text("time :", 600, 75);
  text("temperature : "+tem + "℃", 600,100);
  text("Humidity : " + Humidity + "%", 600,125);
  text("CO2 : " + CO2 + "ppm", 600,150);     
  text("Noise : " + Noise + "dB", 600,175);     
  text("Pressure : " +Pressure + "mb", 600,200);
  
  fnct = 0;
}
  
}
void dispose() {
  println("run dispose method");
}
int LED=13;

void setup()
{
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}
void loop()
{
  /*
  digitalWrite(LED,LOW);   
  delay(5000);
  digitalWrite(LED,HIGH);
  delay(5000);
  */
  
  if(Serial.available()>0)
  {
    char b=Serial.read();
    if(b=='a')
    {
      digitalWrite(LED,LOW);
      delay(1000);
    }
    else if(b=='b')
    digitalWrite(LED,HIGH);
    delay(1000);
  }
  
}

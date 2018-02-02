#include <Servo.h> 
 
Servo myservo;  // create servo object to control a servo 
                // twelve servo objects can be created on most boards
 
int pos = 0; 
int distance = 5;
const int Motor1Pin1 = 8;
const int Motor1Pin2 = 9;
const int Motor2Pin1 = 10;
const int Motor2Pin2 = 11;
#define ECHOPIN 3
#define TRIGPIN 2

void setup()
{
  Serial.begin(9600);
  myservo.attach(6);
  pinMode(Motor1Pin1, OUTPUT);   
  pinMode(Motor1Pin2, OUTPUT);   
  pinMode(Motor2Pin1, OUTPUT);   
  pinMode(Motor2Pin2, OUTPUT);   
  pinMode(ECHOPIN, INPUT);
  pinMode(TRIGPIN, OUTPUT);
}

void loop()
{
  
  GoForward();
  delay(2000);
  GoBackward();
  delay(2000);
  GoRight();
  delay(2000);
  GoLeft();
  delay(2000);
  Stop();
  delay(2000);
  
}
void GoForward(){
  digitalWrite(Motor1Pin2, LOW);
  digitalWrite(Motor1Pin1, HIGH);
  digitalWrite(Motor2Pin2, LOW);
  digitalWrite(Motor2Pin1, HIGH);
}

void GoBackward(){
  digitalWrite(Motor1Pin1, LOW);
  digitalWrite(Motor1Pin2, HIGH);
  digitalWrite(Motor2Pin1, LOW);
  digitalWrite(Motor2Pin2, HIGH);
}

void GoLeft(){
  digitalWrite(Motor1Pin1, LOW);
  digitalWrite(Motor1Pin2, HIGH);
  digitalWrite(Motor2Pin2, LOW);
  digitalWrite(Motor2Pin1, HIGH);
}

void GoRight(){
  digitalWrite(Motor1Pin2, LOW);
  digitalWrite(Motor1Pin1, HIGH);
  digitalWrite(Motor2Pin1, LOW);
  digitalWrite(Motor2Pin2, HIGH);
}

void Stop()
{
  digitalWrite(Motor1Pin2, LOW);
  digitalWrite(Motor1Pin1, LOW);
  digitalWrite(Motor2Pin1, LOW);
  digitalWrite(Motor2Pin2, LOW);
 
 for(pos = 0; pos <= 180; pos += 1) // goes from 0 degrees to 180 degrees 
  {                                  // in steps of 1 degree 
    myservo.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(15);    // waits 15ms for the servo to reach the position 
    digitalWrite(TRIGPIN, LOW);
    delayMicroseconds(2);
    digitalWrite(TRIGPIN,HIGH);
    delayMicroseconds(10);
    digitalWrite(TRIGPIN,LOW);

    float distance = pulseIn(ECHOPIN, HIGH);
    distance=distance/58;
    Serial.print(distance);
    Serial.println("CM");
  } 
  for(pos = 180; pos>=0; pos-=1)     // goes from 180 degrees to 0 degrees 
  {                                
    myservo.write(pos);              // tell servo to go to position in variable 'pos' 
    delay(15);            // waits 15ms for the servo to reach the position 
  
    digitalWrite(TRIGPIN, LOW);
    delayMicroseconds(2);
    digitalWrite(TRIGPIN,HIGH);
    delayMicroseconds(10);
    digitalWrite(TRIGPIN,LOW);

    float distance = pulseIn(ECHOPIN, HIGH);
    distance=distance/58;
    Serial.print(distance);
    Serial.println("CM");
} 
 
 digitalWrite(TRIGPIN, LOW);
 delayMicroseconds(2);
 digitalWrite(TRIGPIN,HIGH);
 delayMicroseconds(10);
 digitalWrite(TRIGPIN,LOW);

 float distance = pulseIn(ECHOPIN, HIGH);
 distance=distance/58;
 Serial.print(distance);
 Serial.println("CM");
}

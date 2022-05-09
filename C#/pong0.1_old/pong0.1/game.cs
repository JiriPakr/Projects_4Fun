using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pong0._1
{
    public class game
    {
        public static SolidBrush sbp = new SolidBrush(Color.White);             // barva paddel
        public static SolidBrush sbb = new SolidBrush(Color.Red);               // barva micku
        public static Rectangle ball = new Rectangle(480, 250, 40, 40);         // micek   
        public static Rectangle paddle1 = new Rectangle(425, 65, 150, 5);       // paddle 1
        public static Rectangle paddle2 = new Rectangle(425, 490, 150, 5);      // paddle hrace           
        
        static double score1;                       // zobrazeje skore 1
        static double score2;                       // zobrazeje skore hrace
        public static double Xspeed = -3;           // rychlost micku v X
        public static double Yspeed = -3;           // rychlost micku v Y
        public static double pXspeed = 2;           // rychlost AI paddlu
        public static double s;                     // nahodne cislo
        public static int p1sm = 3;                 // modifikator rychlosti

        static int RandoMin = 1;                    // urcuje min velikost nahodneho cisla s
        static int RandoMax = 3;                    // urcuje max velikost nahodneho cisla s

        public static int Distance;                 // pozice na paddle hrace
        static int topmax = 1;                      // horni obraj obrazovky
        static int botmax = 519;                    // dolni obraj obrazovky
        static int leftmax = 1;                     // levy obraj obrazovky
        static int rightmax = 940;                  // pravy obraj obrazovky

        static Font Drawfont = new Font("Times", 40);   // font pisma a velikost

        public static void DrawIt(Graphics g)           // funkce na vykresleni
        {
            //Vykresleni tvaru
            g.FillRectangle(sbp, paddle2);
            g.FillRectangle(sbp, paddle1);
            g.FillRectangle(sbb, ball);
            //Vykresleni skore
            g.DrawString(score2.ToString(), Drawfont, sbp, 50, 120);
            g.DrawString(score1.ToString(), Drawfont, sbp, 890, 120);
        }

        public static void Restart()            //reset pozice
        {
            // Puvodni pozice +-stred
            ball.X = 480;
            ball.Y = 250;                                    
            Xspeed = -3;
            Yspeed = -3;
            p1sm = 3;
        }

        public static void ScoreCheck()     // zapise skore a spusti reset
        {
            if (ball.Y < topmax)
            { score2 += 1; Restart(); }
            else if (ball.Y > botmax)
            { score1 += 1; Restart(); }
        }       

        public static void BallMove(Timer t1)       // pohyb a odrazy micku
        {
            ball.X += (int)Xspeed;
            ball.Y += (int)Yspeed;            
            if (ball.X > rightmax || ball.X < leftmax) { Xspeed = -Xspeed; }            
            if (ball.IntersectsWith(paddle1)|| ball.IntersectsWith(paddle2))
            {
                int dst = paddle2.X+140;                        
                Distance = dst - ball.X;
                if (Distance > 110 || Distance < 40) { Random(); }          // pokud se micek odrazi od kraje spusti random
                else { Yspeed = -Yspeed;}                                   // jinak otoci smer rychlosti micku
                if (ball.X > paddle2.X || Xspeed < 0) { Xspeed = -Xspeed; }
                if (ball.X < paddle2.X || Xspeed < 0) { Xspeed = -Xspeed; }                
            }
        }

        static void Random()        // otaci smer rychlost a zvysuje rychlost micku
        {
            Random r = new Random();

            s = r.Next(RandoMin, RandoMax);
            if (ball.IntersectsWith(paddle2) && Xspeed < 0) { Xspeed -= s/4; }
            if (ball.IntersectsWith(paddle2) && Xspeed > 0) { Xspeed += s/4; }
            if (ball.IntersectsWith(paddle1) && Xspeed > 0) { Xspeed += s/4; }
            if (ball.IntersectsWith(paddle1) && Xspeed < 0) { Xspeed -= s/4; }
            Yspeed = -Yspeed;            
            p1sm = r.Next(2, 7);
        }
              
        public static void Paddle2move(Timer t1, int x)         // pohyb paddlu hrace
        {            
            paddle2.X = x;
            if (paddle2.X > rightmax-107) { paddle2.X = rightmax-107; }
            if (paddle2.X < leftmax) { paddle2.X = leftmax; }

        }

        /*public static void Paddle1move(Timer t1, int x)                                  // Zkusebni mod
        {
            paddle1.X = x;
            if (paddle1.X > rightmax - 107) { paddle1.X = rightmax - 107; }
            if (paddle1.X < leftmax) { paddle1.X = leftmax; }
        }*/

        public static void Paddle1DonkeyAI(Timer t1)        // pohyb paddlu 1
        {
            
            if (paddle1.X < ball.X ) { paddle1.X += (int)pXspeed * p1sm; }
            if (paddle1.X > ball.X) { paddle1.X -= (int)pXspeed * p1sm; }
            if (paddle1.X > rightmax - 107) { paddle1.X = rightmax - 107; }
            if (paddle1.X < leftmax) { paddle1.X = leftmax; }
        }      
    }
}

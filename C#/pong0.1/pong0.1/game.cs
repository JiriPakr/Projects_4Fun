using System;
//using System.Collections.Generic;
//using System.ComponentModel;
//using System.Data;
using System.Drawing;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
using System.Windows.Forms;

namespace pong0._1
{
    public class game
    {
        // Velikost Okna
        public static int windowsize_x = 1920;
        public static int windowsize_y = 1060;

        // Vlastnosti micku
        static int ball_pos_x = windowsize_x / 2;
        static int ball_pos_y = windowsize_y / 2;
        static int ball_size = windowsize_x / 20;

        // Vlacnosti paddlů
        static int paddle_pl_pos_x = windowsize_x / 2;
        static int paddle_pl_pos_y = windowsize_y - 65;
        static int paddle_comp_pos_x = windowsize_x / 2;
        static int paddle_comp_pos_y = 65;
        static int paddle_len = windowsize_x / 7;
        static int paddle_wid = windowsize_y / 20;


        // Vykreslene objekty
        public static Rectangle paddle_player = new Rectangle(paddle_pl_pos_x, paddle_pl_pos_y, paddle_len, paddle_wid);
        public static Rectangle paddle_comp = new Rectangle(paddle_comp_pos_x, paddle_comp_pos_y, paddle_len, paddle_wid);
        public static Rectangle ball = new Rectangle(ball_pos_x, ball_pos_y, ball_size, ball_size);
        public static SolidBrush sbp = new SolidBrush(Color.White);
        public static SolidBrush sbb = new SolidBrush(Color.Red);


        //
        static double score1;                       // zobrazeje skore 1
        static double score2;                       // zobrazeje skore hrace
        public static double Xspeed = -3;           // rychlost micku v X
        public static double Yspeed = -3;           // rychlost micku v Y
        public static double pXspeed = 2;           // rychlost AI paddlu
        public static double s;                     // nahodne cislo
        public static int paddle_speed_modifier = 3;                 // modifikator rychlosti player1speed_modifier

        static int RandoMin = 1;                    // urcuje min velikost nahodneho cisla s
        static int RandoMax = 3;                    // urcuje max velikost nahodneho cisla s

        public static int Distance;                 // pozice na paddle hrace
        static int topmax = 1;                      // horni obraj obrazovky
        static int botmax = windowsize_y - 34;                    // dolni obraj obrazovky
        static int leftmax = 1;                     // levy obraj obrazovky
        static int rightmax = windowsize_x-46;                  // pravy obraj obrazovky
        public static int bounce_counter = 0;              // pocitadlo odrazů

       


        static Font Drawfont = new Font("Times", 40);   // font pisma a velikost


        public static void DrawIt(Graphics g)           // funkce na vykresleni
        {
            //Vykresleni tvaru
            g.FillRectangle(sbp, paddle_player);
            g.FillRectangle(sbp, paddle_comp);
            g.FillRectangle(sbb, ball);
            ////Vykresleni skore
            //g.DrawString(score2.ToString(), Drawfont, sbp, 50, 120);
            // g.DrawString(score1.ToString(), Drawfont, sbp, 890, 120);
        }

        public static void Restart()            //reset pozice
        {
            // Puvodni pozice +-stred
            ball.X = windowsize_x/2;
            ball.Y = windowsize_y/2;                                    
            Xspeed = -3;
            Yspeed = -3;
            paddle_speed_modifier = 3;
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
            if (ball.IntersectsWith(paddle_comp))
            {
                BallBounce_Comp();
            }
                
            if (ball.IntersectsWith(paddle_player) && bounce_counter % 2 == 1)
            {
                BallBounce_Player();
            }
        }

        public static void BallBounce_Player()
        {
            
            int dst = paddle_player.X + 140;
            Distance = dst - ball.X;
            if (Distance > 110 || Distance < 40) { Random(); }          // pokud se micek odrazi od kraje spusti random
            else { Yspeed = -Yspeed; bounce_counter++; }                                   // jinak otoci smer rychlosti micku
            if (ball.X > paddle_player.X || Xspeed < 0) { Xspeed = -Xspeed; }
            if (ball.X < paddle_player.X || Xspeed < 0) { Xspeed = -Xspeed; }
            
        }

        public static void BallBounce_Comp()
        {
            Yspeed = -Yspeed; 
            bounce_counter++;
        }


        static void Random()        // otaci smer rychlost a zvysuje rychlost micku
        {
            Random r = new Random();

            s = r.Next(RandoMin, RandoMax);
            if (ball.IntersectsWith(paddle_player) && Xspeed < 0) { Xspeed -= s/4; }
            if (ball.IntersectsWith(paddle_player) && Xspeed > 0) { Xspeed += s/4; }
            if (ball.IntersectsWith(paddle_comp) && Xspeed > 0) { Xspeed += s/4; }
            if (ball.IntersectsWith(paddle_comp) && Xspeed < 0) { Xspeed -= s/4; }
            bounce_counter++;
            Yspeed = -Yspeed;
            paddle_speed_modifier = r.Next(2, 7);
        }
              
        public static void Paddle_player_move(Timer t1, int x)         // pohyb paddlu hrace
        {
            paddle_player.X = x;
            if (paddle_player.X > rightmax-107) { paddle_player.X = rightmax-107; }
            if (paddle_player.X < leftmax) { paddle_player.X = leftmax; }

        }

        /*public static void Paddle1move(Timer t1, int x)                                  // Zkusebni mod
        {
            paddle1.X = x;
            if (paddle1.X > rightmax - 107) { paddle1.X = rightmax - 107; }
            if (paddle1.X < leftmax) { paddle1.X = leftmax; }
        }*/

        public static void Paddle1DonkeyAI(Timer t1)        // pohyb paddlu 1
        {
            
            if (paddle_comp.X < ball.X ) { paddle_comp.X += (int)pXspeed * paddle_speed_modifier; }
            if (paddle_comp.X > ball.X) { paddle_comp.X -= (int)pXspeed * paddle_speed_modifier; }
            if (paddle_comp.X > rightmax - 107) { paddle_comp.X = rightmax - 107; }
            if (paddle_comp.X < leftmax) { paddle_comp.X = leftmax; }
        }      
    }
}

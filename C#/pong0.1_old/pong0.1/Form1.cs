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
    public partial class Form1 : System.Windows.Forms.Form
    {
        bool paused = false;
        bool paused2 = false;        
        SolidBrush sb = new SolidBrush(Color.White);
        public Form1()
        {
            InitializeComponent();        
            timer1.Interval = 1;
            timer1.Start();            
        }

        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            //if (!paused)
           // {
                label1.Text = "Mouse X/Y:" + e.X.ToString() + "/" + e.Y.ToString();     // Test mod - zobrazi souradnice mysi

                game.Paddle2move(timer1, e.X-75);                
           //}
        }                

        private void Form1_Paint(object sender, PaintEventArgs e)
        {                        
                Graphics g = e.Graphics;
                CreateGraphics();
                game.DrawIt(g);            
        }

        private void pause_onclick(object sender, EventArgs e)
        {
            if (!paused && !paused2)
            {
                paused = true;                
            }
            else
            {
                paused = false;
                paused2 = false;
            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (!paused && !paused2)
            {
                label2.Text = "Ball X/Y:" + game.ball.X.ToString() + "/" + game.ball.Y.ToString() + "  XSpeed: " + game.Xspeed.ToString();              // Test mod - zobrazi souradnice micku
                label3.Text = "Paddle1 X/Y:" + game.paddle1.X.ToString() + "/" + game.paddle2.Y.ToString() + "  P1SM: " + game.p1sm.ToString();         // Test mod - zobrazi souradnice paddlu1
                label4.Text = "Paddle2 X/Y:" + game.paddle2.X.ToString() + "/" + game.paddle2.Y.ToString();                                             // Test mod - zobrazi souradnice paddlu2

                Refresh();
                game.BallMove(timer1);
                game.ScoreCheck();
                game.Paddle1DonkeyAI(timer1);
            }
        }

        private void Form1_MouseLeave(object sender, EventArgs e)
        {
            paused2 = true;
        }

        private void Form1_MouseEnter(object sender, EventArgs e)
        {
            paused2 = false;
        }

        private void restartToolStripMenuItem_Click(object sender, EventArgs e)
        {
            game.Restart();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }       
    }




}

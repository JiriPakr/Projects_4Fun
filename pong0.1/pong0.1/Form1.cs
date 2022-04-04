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
        bool devtools_toggle = false;
        bool score_toggle = false;
        SolidBrush sb = new SolidBrush(Color.White);
        

        public Form1()
        {
            InitializeComponent();
            timer1.Interval = 1;
            timer1.Start();
            
        }

        private void set_default_settings()
        {
            label1.Visible = true;
            label2.Visible = true;
            label3.Visible = true;
            label4.Visible = true;
            label5.Visible = true;
            SCORE_PL.Visible = true;
            SCORE_PL.Visible = true;
            SCORE_PL_LABEL.Visible = true;
            SCORE_COMP.Visible = true;
            SCORE_COMP.Visible = true;
            SCORE_COMP_LABEL.Visible = true;
            SCORE_PL.Text = "0";
            SCORE_COMP.Text = "0";
        }
        
        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            //if (!paused)
           // {
                label1.Text = "Mouse X/Y:" + e.X.ToString() + "/" + e.Y.ToString();     // Test mod - zobrazi souradnice mysi

            game.Paddle_player_move(timer1, e.X-75);                
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
                label3.Text = "Paddle_player X/Y:" + game.paddle_player.X.ToString() + "/" + game.paddle_player.Y.ToString() + "  PLSM: " + game.paddle_speed_modifier.ToString();         // Test mod - zobrazi souradnice paddlu1
                label4.Text = "Paddle_comp X/Y:" + game.paddle_comp.X.ToString() + "/" + game.paddle_comp.Y.ToString();      // Test mod - zobrazi souradnice paddlu2
                label5.Text = "Bounce_counter:" + game.bounce_counter.ToString();       // Test mod - zobrazi odrazy

                Refresh();
                game.BallMove(timer1);
                game.ScoreCheck();
                game.Paddle1DonkeyAI(timer1);
                devtools_show();
                score_show();
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

        private void devToolsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!devtools_toggle)
            { devtools_toggle = true; }
            else { devtools_toggle = false; }         
        }

        private void devtools_show()
        {
            if (devtools_toggle == true)
            {
                label1.Visible = true;
                label2.Visible = true;
                label3.Visible = true;
                label4.Visible = true;
                label5.Visible = true;
            }

            else if (devtools_toggle == false)
            {
                label1.Visible = false;
                label2.Visible = false;
                label3.Visible = false;
                label4.Visible = false;
                label5.Visible = false;
            }
        }

        private void scoreToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!score_toggle)
            { score_toggle = true; }
            else { score_toggle = false; }

            SCORE_PL.Text= "0";
            SCORE_COMP.Text = "0";
        }

        private void score_show()
        {
            if (score_toggle == true)
            {
                SCORE_PL.Visible= true;
                SCORE_PL_LABEL.Visible = true;
                SCORE_COMP.Visible = true;
                SCORE_COMP_LABEL.Visible = true;
            }

            else if (score_toggle == false)
            {
                SCORE_PL.Visible = false;
                SCORE_PL_LABEL.Visible = false;
                SCORE_COMP.Visible = false;
                SCORE_COMP_LABEL.Visible = false;
            }
        }

    }




}

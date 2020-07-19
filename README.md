# Distance-Calc
Hey there folks! The purpose of this code is to calculate how far we think the balloonerang will travel/other flight and atmospheric characteristics. The code assumes that the glider weighs 2kg.
How to run it: In main, specify some vals in EASVector and LDVector you get from XFLR5/somewhere else. EASVector is the estimated air speed and LDVector is the lift to drag ratio at each of these speeds. Then, run main and watch what happens! You get some cool graphs and a print statement of how far the glider goes. 
How it works: The code takes the values given in main, optimizes them to figure out how fast it should travel at each altitude for the longest distance, and then prints that max distance in the console. 
Have fun and join the slack channel #balloons-balloonerang in the SSI or SUAVE slacks if you have any questions/want to learn more!

------------------------------------------------------------------------------------
COMP61021: Modelling and Visualization of High Dimensional Data

Lab 2: Self-Organizing Map Implementation and Application
------------------------------------------------------------------------------------
The sumbmited folder has structure below (Important files):

YanLiu-lab2/
    readme.txt                  - this file, instructions for experiment

    report.pdf                  - the report for this lab

    lab2_Part1/ 		        - the code folder for Part 1                
        lab_som.m               - the Implementation of one-dimensional SOM 
        lab_som2d.m             - the Implementation of two-dimensional SOM 
        lab_som_test.m          - test the one-dimensional SOM with suitable parameters
        lab_som2d_test.m        - test the two-dimensional SOM with suitable parameters
            ...

    lab2_Part3/                - the code folder for Part 3   
        lab_features.m          - completed lab_features

---------------------------------------------------------------------------------------------------

                                    Part 1 instructions               
To test my implementation in Part 1, Please locate（open） the 'lab2_Part1' folder in matlab, then you can test.

-----------------------------
1. lab_som.m instructions
-----------------------------
First of all, I get number of example and dimension.
Then do weight initialization. I use sample initialization, where the weight vectors are initialized with random samples drawn from the input data set
Next I define tau1 and tau2. Then do iteration:
    1. Randomly pick an input vector from training dataset.
    2. Get the winner (closest) neuron
    3. Find neighbor neuron of the winner neuron
    4. Update the weights of the winner and its neighbors
    5. Decrease the learningRate and the radius

The parameters i choose for 1-D SOM is lab_som(data, 20, 5000, 0.1, 10).

To test my code, you can just open "lab_som_test.m" file, then click on 'run' button!
Or you can use the Matlab command like this:
    1. data=nicering;
    2. som=lab_som(data, 20, 5000, 0.1, 10); 
    3. lab_vis(som, data);

-----------------------------
2. lab_som2d.m instructions
-----------------------------
The step-by-step procedure for this file is similar to the Implementation of one-dimensional SOM above.
You can see the details of procedure from the comments in the code.

The parameters i choose for 2-D SOM is lab_som2d(data, 10, 10, 15000, 0.1, 5).

To test my implementation, you can just open "lab_som2d_test.m" file, then click on 'run' button!
Or you can use the Matlab command like this:
    1. data=nicering;
    2. [som,grid]=lab_som2d(data, 10, 10, 15000, 0.1, 5); 
    3. lab_vis2d(som, grid, data);

------------------------------------------------------------------------------------------------------
                                Part 2 instructions
Test this according to the command provided by the teacher on the assignment. That is 
1. [imgs,training]=lab_featuresets('x:\the\Path\To\Images\', -1);
2. som_gui；
using Load/Save->Save Map  with a name as som
3. som_show(som, 'umat', 'all')
4. lab_showsimilar(imgs,training,som.codebook,1)

The best parameters for part2（som_gui） I found is :
    map sieze: 11*10
    initialization type: linear
    initialization lattice: hexa
    initialization shape: sheet
    training type: sequential
    neigh: gussisan
    tracking:1
    Rough:
        radius initial: 6
        radius final: 2
        traning length:1000
    Finetune:
        radius initial: 2
        radius final: 0
        traning length:200

The mean quantization error is 1.2979 (command is : som_quality(som, training)
You you can see the picture in my repot to see clearly and intuitively parameters setting.

------------------------------------------------------------------------------------------------------

                                Part 3 instructions
                                
First of all, I define the colors by RGB format[0-255,0-255,0-255,] named rgb_bucket which contains 8 types of color. 
Therefore, the fHistogramRGB is a 1*8*1 matrix and I create such matrix to store the result. 
Then I iterate the input image and each pixel's proximity to each bucket is measured. To implement this, I calculate the minimum distance between rgb_pixel and rgb_bucket, 
in this way, we can find which color it belongs to.
 And then we can increment the count of that bucket. 
 Finally, we can get the return value: fHistogramRGB.
  For RGB Area, I divided the image up into a grid. 
  Then calculate the average color of each grid cell. This is very similar to Greyscale Area. 
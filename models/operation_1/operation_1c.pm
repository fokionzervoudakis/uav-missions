dtmc

const int max_e1 = 70; // maximum endurance
const int max_d1 = 71; // maximum duration and point of failure

module ARDrone1

    e1 : [0..max_e1] init max_e1; // endurance

    [actn1] e1>0 & d1>0 -> (e1'=e1-1);
    []      e1=0 | d1=0 -> true;

endmodule

module HoverAction1

    d1 : [0..max_d1] init max_d1; // duration

    [actn1] d1>0 & e1>0 -> (d1'=d1-1);

endmodule
====================================
How operational space define a robot
====================================



"The mistake that advanced engineer easy to make is optimizing the things that shouldn't exist". So, when there is a proposal about making a
robot. The very first question is where is this robot gonna work, in kinematics, which space does operational space exist in, in mathametical,
which group does robot are gonna operated in.

Here are several examples:

Vacuume cleaning robot.
In most case, it runs on 100m^2 2D space so its operation space is R3 which are x, y and theta(orientation). So if we wanna has a fully-actuated
robot

Manipulator
It need to control the 6 dimentions in operational space(3 position and 3 orientation) to finish tasks. So a reasonal design wournd be a 6 actuator.

The reason why extra actuator/motor, aka over-actuated usually not a good choice in reality, especially in business world. Lets check gain and loss

If we take manipulator as a example, if we and 6 + n actuators for manipulation. 

The marginal cost are

  * Extra N x actuators.
  * Extra N x links, at least
  * It is safe to think this N extra actuator + links are connected to the end of 6 actuators. The energy of each actuators of previous 6 are bumped.
  * Extra solution of kinematics/dynamics, more calculation.
 
The possible marginal revenue are
  
  * larger dexterous space
  * larger reachable space
  * larger dexterous space ratio 
  * condition number closer to 1


In reality, what we need in operational space is just enough, no more. Extra will hurt you in financial, engineering time and mantainess. Sometimes,
to add robust, people are tend to use under-actuated structure to achieve the task. One of the example is car, you only get gas paddle and wheel, two
acutator but we need to control 3 variables in operational space(x, y and theta).

Eventually, I do believe overactuated robot are not gonna work or very easy to be beated by fully or under actuated robot. For example, to achieve
the movement task(x, y and theta) in home service domain, humanoid robot or quaduped robot are not good choice comparing to vacuume cleaning platform.

Even, you determine the number of actuator, you still need to determine the size of links and structures. Those size of links are easy to influence
the operational space by butterfly effect which make operational ability very sensitive to very small change of those size value.

The fact that make thing worst is engineers are always tend to make robot more complex than need to achieve maybe more complex/interesting algorithm
and deploy a new optimization calculation from some paper.

So the choice of actuator need to be minimized.
the size of links need to be optimized, maybe by simulation of exhaustion of parameters

#ifndef RECTANGLE_H
#define RECTANGLE_H

#include <Eigen/Dense>
#include "cppTypes.h"

namespace shapes {
  class Rectangle {
    public:
      int x0, y0, x1, y1;
      float var;
      Rectangle();
      Rectangle(int x0, int y0, int x1, int y1);
      ~Rectangle();
      int getArea();
      void getSize(int* width, int* height);
      void move(int dx, int dy);
      float getAverage();
    private:
      Vec4<int> data;
  };
}

#endif

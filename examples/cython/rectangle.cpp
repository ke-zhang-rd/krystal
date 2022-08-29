#include <iostream>
#include "rectangle.h"

namespace shapes {
	// Default constructor
    Rectangle::Rectangle () {}
	// Overloaded constructor
	Rectangle::Rectangle (int x0, int y0, int x1, int y1) {
		this->x0 = x0;
		this->y0 = y0;
		this->x1 = x1;
		this->y1 = y1;
		data << x0, y0, x1, y1;
		std::cout << "data:" << std::endl;
		std::cout << data << std::endl;
    }

    // Destructor
    Rectangle::~Rectangle () {}

	// Return the area of the rectangle
	int Rectangle::getArea () {
		// return (this->x1 - this->x0) * (this->y1 - this->y0);
		return (data[2] - data[0] ) * (data[3] - data[1]);
    }
	// Get the size of the rectangle.
	// Put the size in the pointer args
	void Rectangle::getSize (int *width, int *height) {
		(*width) = x1 - x0;
		(*height) = y1 - y0;
	}

	// Move the rectangle by dx dy
	void Rectangle::move (int dx, int dy) {
		this->x0 += dx;
		this->y0 += dy;
		this->x1 += dx;
		this->y1 += dy;
	}
}


namespace optimization {
	Vec4d ccompute_d(Vec4d vec) {
		Vec4d res;
		double tmp = (vec[0] + vec[1] + vec[2] + vec[3]) / 4.0;
		res << tmp, tmp, tmp, tmp;
		std::cout << "inside optimization namespace" << std::endl;
		return res;
	}
	Vec4f ccompute_f(Vec4f vec) {
		Vec4f res;
		float tmp = (vec[0] + vec[1] + vec[2] + vec[3]) / 4.0;
		res << tmp, tmp, tmp, tmp;
		std::cout << "inside optimization namespace" << std::endl;
		return res;
	}
}

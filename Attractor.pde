class AttractorPt {
	PVector pos;
	color col;

	AttractorPt(PVector p, color c) {
		pos = p;
		col = c;
	}
}

class Attractor {
	String name;
	int maxIter = 50000; // default number of iterations
	PVector lastPt;

	float magFactor = 1; // default magnification factor for points
	float adjX = 0;
	float adjY = 0;

	AttractorPt[] pts = {};
	PVector minPt;
	PVector maxPt;

	float colorStep = 0.0008;
	float ptRadius = 1;

	Attractor() {
		pts = new AttractorPt[maxIter];
		PVector pos;
		color col;
		for (int i = 0; i < maxIter; ++i) {
			pos = new PVector();
			col = color(0, 100, 100, 1);
			pts[i] = new AttractorPt(pos, col);
		}
	}

	void genPts() {
//		pts = new AttractorPt[maxIter];
//		minPt = lastPt.get();
//		maxPt = lastPt.get();
		AttractorPt extPt;
		PVector newPos;
		color newColor;
		for (int i = 0; i < maxIter; ++i) {
			extPt = pts[i];
			newPos = nextPt();
			newColor = getColor(newPos.dist(extPt.pos));
			extPt.col = newColor;
			extPt.pos.set(newPos);
//			setMinMax(minPt, maxPt, newPos);
		}
	}

	// stub, should be overridden
	PVector getNext() { return new PVector(0, 0, 0); }

	PVector nextPt() {
		PVector nextPt = getNext();
		lastPt = nextPt;
		return nextPt;
	}

	color getColor(float dist) {
		int deg = round(280 + (1 - dist / 3) * 360) % 360;
		return color(deg, 100, 100, 1);
	}

	float convNoisePos(float noiseInd) {
		return noise(noiseInd) * 255;
	}

	void setMinMax(PVector min, PVector max, PVector pt) {
		util.calcVecMin(min, pt);
		util.calcVecMax(max, pt);
	}

	// in case any update logic needs to be run between frames
	void update() { }

	void draw() {
		noStroke();
		pushMatrix();
		translate(width / 2 + adjX, height / 2 + adjY);
		for (int i = 0, l = pts.length; i < l; ++i) {
			drawPt(pts[i]);
		}
		popMatrix();
	}

	void drawPt(AttractorPt pt) {
		pushMatrix();
		translate(pt.pos.x * magFactor, pt.pos.y * magFactor);
		fill(pt.col);
		rect(0, 0, ptRadius, ptRadius);
		popMatrix();
	}

	// stub, should be overridden
	String[] getParamsDisplay() { return new String[0]; }

	void drawParams() {
		// add parameter labels
		fill(255);
		textSize(14);
		int xPos = width - 100;
		int yOff = 20;
		String[] dispParams = getParamsDisplay();
		for (int i = 0, len = dispParams.length; i < len; ++i) {
			text(dispParams[i], xPos, yOff * (i + 1));
		}
	}

	/* default parameter update does nothing */
	boolean updateParam(int paramNum, float inc) {
		return false;
	}

}
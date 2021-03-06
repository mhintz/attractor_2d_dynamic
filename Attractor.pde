class AttractorPt {
	PVector pos;
	color col;
	float dist;

	AttractorPt(PVector p, color c) {
		dist = 0;
		pos = p;
		col = c;
	}
}

class Attractor {
	String name;
	PVector lastPt;
	float magFactor = 1; // default magnification factor for points

	int maxIter = 60000; // default number of iterations

	float centerX = width / 2;
	float centerY = height / 2;
	float adjX = 0;
	float adjY = 0;

	AttractorPt[] pts = {};

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

	// resets initial conditions
	void reset() {
		lastPt = new PVector(0, 0, 0);
	}

	void genPts() {
		reset();

		float maxDist = 0.1;
		AttractorPt extPt;
		for (int i = 0; i < pts.length; ++i) {
			extPt = pts[i];
			PVector oldPos = lastPt;
			PVector newPos = nextPt();
			float dist = newPos.dist(oldPos);
			if (!Float.isInfinite(dist)) maxDist = Math.max(dist, maxDist);
			extPt.dist = dist;
			extPt.pos.set(newPos);
		}
		for (int i = 0, l = pts.length; i < l; ++i) {
			extPt = pts[i];
			extPt.col = util.getColorFromDist(extPt.dist, maxDist);
		}
	}

	// stub, should be overridden
	PVector getNext() { return new PVector(0, 0, 0); }

	PVector nextPt() {
		PVector nextPt = getNext();
		lastPt = nextPt;
		return nextPt;
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
		translate(centerX + adjX, centerY + adjY);
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
		fill(COLOR_MAX);
		textSize(14);
		int xPos = width - 100;
		int yOff = 20;
		String[] dispParams = getParamsDisplay();
		for (int i = 0, len = dispParams.length; i < len; ++i) {
			text(dispParams[i], xPos, yOff * (i + 1));
		}
	}

	/* default parameter update does nothing */
	void updateParam(int paramNum, float inc) { }

}
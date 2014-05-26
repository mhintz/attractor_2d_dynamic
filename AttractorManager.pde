class AttractorManager {

	Attractor mainAttractor = new Attractor();

	void setupAttractor(int index) {
		mainAttractor = makeAttractor(index);
		mainAttractor.genPts();
	}

	void update() {
		mainAttractor.update();
	}

	void draw() {
		mainAttractor.draw();
		mainAttractor.drawParams();
	}

	void updateAttractorParam(int paramNum, float inc) {
		boolean resetParams = mainAttractor.updateParam(paramNum, inc);
		// genNewParams should return true if new params are generated
		if (resetParams) mainAttractor.genPts();
	}

	void saveFrame() {
		save("frames/"+mainAttractor.name+"-"+(System.currentTimeMillis() / 1000L)+".png"); // use unix time seconds as a uuid
	}

	Attractor makeAttractor(int index) {
		Attractor newAtrctr;
		switch (index) {
			case 0: newAtrctr = new CliffordAttractor(); break;
			case 1: newAtrctr = new PeterDeJongAttractor(); break;
			case 2: newAtrctr = new PickoverAttractor(); break;
			default: newAtrctr = new Attractor(); break;
		}
		return newAtrctr;
	}

	String[] getAvailableAttractors() {
		return attractorNames;
	}

	String[] attractorNames = { "Clifford", "Peter De Jong", "Pickover" };
}
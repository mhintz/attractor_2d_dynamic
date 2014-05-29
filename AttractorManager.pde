class AttractorManager {

	Attractor mainAttractor = new Attractor();

	void setupAttractor(int index) {
		mainAttractor = makeAttractor(index);
		mainAttractor.genPts();
	}

	void update() {
		mainAttractor.update();
		mainAttractor.genPts();
	}

	void updateAttractorParam(int paramNum, float inc) {
		mainAttractor.updateParam(paramNum, inc);
		mainAttractor.genPts();
	}

	void draw() {
		mainAttractor.draw();
		mainAttractor.drawParams();
	}

	void saveFrame() {
		save("frames/"+mainAttractor.name+"-"+(System.currentTimeMillis() / 1000L)+".png"); // use unix time seconds as a uuid
	}

	Attractor makeAttractor(int index) {
		Attractor newAtrctr;
		switch (index) {
			case 0: newAtrctr = new AlteredQualiaAttractor(); break;
			case 1: newAtrctr = new CliffordAttractor(); break;
			case 2: newAtrctr = new CliffordAttractor2(); break;
			case 3: newAtrctr = new CosCosCosCosAttractor(); break;
			case 4: newAtrctr = new DuffingAttractor(); break;
			case 5: newAtrctr = new HenonAttractor(); break;
			case 6: newAtrctr = new KingsDreamAttractor(); break;
			case 7: newAtrctr = new PeterDeJongAttractor(); break;
			case 8: newAtrctr = new PhillipHamAttractor(); break;
			case 9: newAtrctr = new PickoverAttractor(); break;
			case 10: newAtrctr = new TinkerbellAttractor(); break;
			default: newAtrctr = new Attractor(); break;
		}
		return newAtrctr;
	}

	String[] getAvailableAttractors() {
		return attractorNames;
	}

	String[] attractorNames = { "Altered Qualia", "Clifford", "Clifford 2", "4 Cosines", "Duffing", "Henon", "King's Dream", "Peter De Jong", "Phillip Ham", "Pickover", "Tinkerbell"};
}
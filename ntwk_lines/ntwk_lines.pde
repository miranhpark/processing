Drawing drawlines;

void setup() {
  size(1000,500);  
  drawlines = new Drawing();
  
  for (int i = 0; i < 0; i++) {
    drawlines.addParticle(new Particle(new PVector(random(50,950),random(50,450))));
  }
}

void draw() {
  background(29,33,36);
  drawlines.run();
  filter(DILATE);
  filter(ERODE);
}

void mousePressed() {
  drawlines.addParticle(new Particle(new PVector(mouseX, mouseY)));
}

class Drawing { 
  ArrayList<Particle> particles;
  
  Drawing() {
    particles = new ArrayList<Particle>();  
  }
  
  void run() {
    for (Particle p : particles) {
      p.run(particles);
    } 
  }
  
  void addParticle(Particle p) {
    particles.add(p);
  }
}

class Particle {
  PVector location;
  PVector velocity;
  float t;
  float a1;
  float a2;
  
  Particle(PVector l) {
    location = l.get();
    velocity = new PVector(0,0);
    t = 2;
    a1 = random(0,100) * 0.1;
    a2 = random(0,100) * 0.01;
  }
  
  void run(ArrayList<Particle> particles) {
    drawLines(particles);
    update();
  }
  
  void update() {
//    location.add(velocity);
    if (t < 2 * PI) { 
      t += 0.1;  
    } else { 
      t = 0; 
    }
    location.add(new PVector(a1 * sin(t), a2 * cos(t)));
  }
  
  void drawLines(ArrayList<Particle> particles) {
    float bound = 150.0f;
    for (Particle other : particles) { 
      float d = PVector.dist(location, other.location);
      
      ellipse(location.x, location.y,1,1);
      fill(255,255,255,50);
      ellipse(other.location.x, other.location.y,1,1);
      fill(255,255,255,50);
      
      if ((d > 0) && (d < bound)) { 
//        if (random(2) > 0.5){
          line(location.x, location.y, other.location.x, other.location.y);
//          stroke(163,167,168, 150 - (140 * (d * d / 75.0 / 75.0) + 10));
          stroke(0,255,255, 150 - (140 * (d * d / 75.0 / 75.0) + 0));
//        }
      }
    }
  }
}


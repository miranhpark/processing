ParticleSystem ps;

void setup() {
  size(800,600);
  ps = new ParticleSystem(new PVector(width/2,height/2));
}

void draw() {
  float border = 100;
  background(0);
  if(random(-5.0,2.0) > 0){
    ps.addParticle(new Particle(new PVector(random(border,width-border),random(border,height-border))));
  }
  ps.run();
  filter(BLUR,1);
}

void mousePressed() {
  ps.addParticle(new Particle(new PVector(mouseX, mouseY)));
}

// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float tx,ty;
  float tsize;

  Particle(PVector l) {
    velocity = new PVector(random(-1.0,1.0),random(-1.0,1.0));
    location = l.get();
    lifespan = 500.0;
    tx = 0;
    ty = 0;
    tsize = 0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
//    acceleration = new PVector(random(-0.001, 0.01), random(-0.001, 0.01));
    acceleration = new PVector(noise(tx)*random(-5.0, 5.0), noise(ty)*random(-5.0, 5.0));
    velocity.add(acceleration);
    location.add(velocity);
    if(random(-1.0,1.0) > 0){
      lifespan -= 75.0;
    }
    tx += 0.01;
    ty += 0.01;
  }

  // Method to display
  void display() {
    color c = #CCFF66;
    stroke(c, max(lifespan, 0.0));
    fill(c, max(lifespan, 0.0));
    ellipse(location.x,location.y,8,8);
    tsize += 0.01; 
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}


// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
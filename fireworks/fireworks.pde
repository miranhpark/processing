import ddf.minim.*;

ArrayList<ParticleSystem> systems;
Minim minim;
AudioPlayer player;

void setup() {
  size(800, 400);
  systems = new ArrayList<ParticleSystem>();
  minim = new Minim(this);
  player = minim.loadFile("firework.wav");
}

void draw() {
  background(0);
  for (int i = systems.size()-1; i >= 0; i--) {
    ParticleSystem ps = (ParticleSystem) systems.get(i);
    ps.run();
    if (ps.dead()) {
      systems.remove(i);
    }
  }
}

void mousePressed() {
  float r, g, b;
  player.play();
  player.rewind();
  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
  systems.add(new ParticleSystem(int(random(100, 150)), new PVector(mouseX, mouseY), r, g, b)); 
}



// An ArrayList is used to manage the list of Particles

class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed
  float r, g, b;

  ParticleSystem(int num, PVector v, float r, float g, float b) {
    particles = new ArrayList<Particle>();   // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, r, g, b));    // Add "num" amount of particles to the arraylist
    }
  }

  void run() {
    // Cycle through the ArrayList backwards, because we are deleting while iterating
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void addParticle() {
    Particle p;
    p = new Particle(origin, r, g, b);
    particles.add(p);
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    return particles.isEmpty();
  }
}


// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float red, green, blue;

  Particle(PVector l, float r, float g, float b) {
    acceleration = new PVector(0, random(0, 0.02));
    velocity = new PVector(random(-1, 1), random(-2.0, 0));
    location = l.get();
    lifespan = random(100, 255);
    red = r;
    green = g;
    blue = b;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    if (lifespan > 100) {
      lifespan -= 5.0;
    } else {
      lifespan -= 30*random(-5,10);
    }
  }

  // Method to display
  void display() {
    noStroke();
    fill(red, green, blue, lifespan);
    ellipse(location.x, location.y, 5,5);
    noStroke();
    fill(255,255,255, lifespan);
    ellipse(location.x, location.y, 3, 3);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
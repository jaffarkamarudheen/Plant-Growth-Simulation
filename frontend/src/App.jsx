import React from 'react';
import PlantSimulator from './components/PlantSimulator';

function App() {
  return (
    <div style={{ padding: '2rem', maxWidth: '1200px', margin: '0 auto' }}>
      <header style={{ marginBottom: '3rem', textAlign: 'center' }}>
        <h1 className="gradient-text" style={{ fontSize: '3rem', fontWeight: '800' }}>FloraSim</h1>
        <p style={{ color: 'var(--text-secondary)' }}>Advanced Plant Growth Simulation System</p>
      </header>

      <main>
        <PlantSimulator />
      </main>

      <footer style={{ marginTop: '5rem', textAlign: 'center', color: 'var(--text-secondary)', fontSize: '0.8rem' }}>
        <p>&copy; 2026 FloraSim. All rights reserved.</p>
      </footer>
    </div>
  );
}

export default App;

import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

const StatsDashboard = ({ history }) => {
  if (!history || history.length === 0) {
    return (
      <div className="glass-card" style={{ marginTop: '2rem', textAlign: 'center' }}>
        <p style={{ color: 'var(--text-secondary)' }}>No data available yet. Start the simulation!</p>
      </div>
    );
  }

  return (
    <div className="glass-card" style={{ marginTop: '2rem' }}>
      <h3 style={{ marginBottom: '1.5rem' }}>Growth & Health History</h3>
      <div style={{ height: '300px', width: '100%' }}>
        <ResponsiveContainer width="100%" height="100%">
          <LineChart data={history}>
            <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.1)" />
            <XAxis dataKey="day" stroke="#94a3b8" />
            <YAxis stroke="#94a3b8" />
            <Tooltip 
              contentStyle={{ background: '#1e293b', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '8px' }}
              itemStyle={{ color: '#fff' }}
            />
            <Line type="monotone" dataKey="growth" stroke="#2ecc71" strokeWidth={3} dot={false} name="Growth %" />
            <Line type="monotone" dataKey="health" stroke="#ef4444" strokeWidth={3} dot={false} name="Health %" />
          </LineChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
};

export default StatsDashboard;

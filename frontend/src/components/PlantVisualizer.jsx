import React from 'react';
import { motion } from 'framer-motion';

const PlantVisualizer = ({ growth, status }) => {
  const height = (growth / 100) * 180;
  const isDead = status === 'dead';
  const isWithered = status === 'withered';
  
  const stemColor = isDead ? '#795548' : (isWithered ? '#8bc34a' : '#4caf50');
  const leafColor = isDead ? '#5d4037' : (isWithered ? '#9ccc65' : '#81c784');

  return (
    <div className="plant-container">
      <div className="stem" style={{ height: `${height}px`, backgroundColor: stemColor }}>
        {growth > 20 && (
          <motion.div 
            initial={{ scale: 0 }} 
            animate={{ scale: 1 }} 
            className="leaf leaf-left" 
            style={{ bottom: '20%', backgroundColor: leafColor }} 
          />
        )}
        {growth > 50 && (
          <motion.div 
            initial={{ scale: 0 }} 
            animate={{ scale: 1 }} 
            className="leaf leaf-right" 
            style={{ bottom: '50%', backgroundColor: leafColor }} 
          />
        )}
        {growth > 80 && (
          <motion.div 
            initial={{ scale: 0 }} 
            animate={{ scale: 1 }} 
            className="leaf leaf-left" 
            style={{ bottom: '80%', backgroundColor: leafColor }} 
          />
        )}
      </div>
      <div className="pot"></div>
    </div>
  );
};

export default PlantVisualizer;

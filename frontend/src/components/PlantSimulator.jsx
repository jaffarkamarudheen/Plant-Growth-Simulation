import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Sun, Droplets, Leaf, Activity } from 'lucide-react';
import PlantVisualizer from './PlantVisualizer';
import StatsDashboard from './StatsDashboard';

const API_BASE = 'http://127.0.0.1:8000/api';

const PlantSimulator = () => {
    const [availablePlants, setAvailablePlants] = useState([]);
    const [myPlants, setMyPlants] = useState([]);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    useEffect(() => {
        fetchInitialData();
    }, []);

    const fetchInitialData = async () => {
        try {
            setLoading(true);
            const [plantsResp, statusResp] = await Promise.all([
                axios.get(`${API_BASE}/plants`),
                axios.get(`${API_BASE}/plant/status`)
            ]);
            setAvailablePlants(plantsResp.data);
            setMyPlants(statusResp.data);
            setLoading(false);
        } catch (err) {
            console.error(err);
            setError("Failed to fetch data from backend.");
            setLoading(false);
        }
    };

    const [selectedPlant, setSelectedPlant] = useState(null);

    const selectPlant = async (plantId) => {
        try {
            setLoading(true);
            await axios.post(`${API_BASE}/plant/select`, { plant_id: plantId });
            const statusResp = await axios.get(`${API_BASE}/plant/status`);
            setMyPlants(statusResp.data);
            setLoading(false);
        } catch (err) {
            setError("Failed to select plant.");
            setLoading(false);
        }
    };

    const provideCare = async (userPlantId, type) => {
        try {
            await axios.post(`${API_BASE}/plant/care`, { user_plant_id: userPlantId, type });
            const statusResp = await axios.get(`${API_BASE}/plant/status`);
            setMyPlants(statusResp.data);
            if (selectedPlant && selectedPlant.id === userPlantId) {
                const updated = statusResp.data.find(p => p.id === userPlantId);
                setSelectedPlant(updated);
            }
        } catch (err) {
            setError("Failed to provide care.");
        }
    };

    const [editingPlant, setEditingPlant] = useState(null);
    const [editForm, setEditForm] = useState({
        name: '',
        category: 'small',
        base_growth_days: 30,
        water_requirement: 'medium',
        sunlight_requirement: 'medium'
    });

    const triggerGrowth = async () => {
        if (!selectedPlant) return;
        try {
            setLoading(true);
            await axios.post(`${API_BASE}/plant/update-growth`);
            const statusResp = await axios.get(`${API_BASE}/plant/status`);
            setMyPlants(statusResp.data);
            const updated = statusResp.data.find(p => p.id === selectedPlant.id);
            setSelectedPlant(updated);
            setLoading(false);
        } catch (err) {
            setError("Failed to update growth.");
            setLoading(false);
        }
    };

    const startEditing = (plant) => {
        setEditingPlant(plant.id);
        setEditForm({ ...plant });
    };

    const [showAddForm, setShowAddForm] = useState(false);
    const [newPlantForm, setNewPlantForm] = useState({
        name: '',
        category: 'small',
        base_growth_days: 30,
        water_requirement: 'medium',
        sunlight_requirement: 'medium'
    });

    const handleAddPlant = async () => {
        try {
            setLoading(true);
            await axios.post(`${API_BASE}/plants`, newPlantForm);
            const plantsResp = await axios.get(`${API_BASE}/plants`);
            setAvailablePlants(plantsResp.data);
            setNewPlantForm({
                name: '',
                category: 'small',
                base_growth_days: 30,
                water_requirement: 'medium',
                sunlight_requirement: 'medium'
            });
            setShowAddForm(false);
            setLoading(false);
        } catch (err) {
            setError("Failed to add new plant type.");
            setLoading(false);
        }
    };

    const handleDeletePlant = async (id) => {
        if (!window.confirm("Are you sure? This will remove this species from the selection.")) return;
        try {
            setLoading(true);
            await axios.delete(`${API_BASE}/plants/${id}`);
            const plantsResp = await axios.get(`${API_BASE}/plants`);
            setAvailablePlants(plantsResp.data);
            setLoading(false);
        } catch (err) {
            setError("Failed to delete plant type.");
            setLoading(false);
        }
    };

    const removeUserPlant = async (id, e) => {
        if (e) e.stopPropagation();
        if (!window.confirm("Remove this plant from your garden? This cannot be undone.")) return;
        try {
            setLoading(true);
            await axios.delete(`${API_BASE}/plant/user-plant/${id}`);
            const statusResp = await axios.get(`${API_BASE}/plant/status`);
            setMyPlants(statusResp.data);
            if (selectedPlant && selectedPlant.id === id) setSelectedPlant(null);
            setLoading(false);
        } catch (err) {
            setError("Failed to remove plant from garden.");
            setLoading(false);
        }
    };

    const handleUpdatePlant = async () => {
        try {
            setLoading(true);
            await axios.put(`${API_BASE}/plants/${editingPlant}`, editForm);
            const plantsResp = await axios.get(`${API_BASE}/plants`);
            setAvailablePlants(plantsResp.data);
            setEditingPlant(null);
            setLoading(false);
        } catch (err) {
            setError("Failed to update plant configuration.");
            setLoading(false);
        }
    };

    const handleCareChange = async (type, val) => {
        if (!selectedPlant) return;
        let level = 'low';
        if (val > 66) level = 'high';
        else if (val > 33) level = 'medium';

        try {
            await axios.post(`${API_BASE}/plant/care`, { 
                user_plant_id: selectedPlant.id, 
                type: type,
                level: level 
            });
            const statusResp = await axios.get(`${API_BASE}/plant/status`);
            const updated = statusResp.data.find(p => p.id === selectedPlant.id);
            setSelectedPlant(updated);
            setMyPlants(statusResp.data);
        } catch (err) {
            setError("Failed to update care level.");
        }
    };

    const getLevelValue = (level) => {
        if (level === 'high') return 100;
        if (level === 'medium') return 50;
        return 20;
    };

    const getConditionStatus = (type, current) => {
        if (!selectedPlant) return null;
        const req = type === 'sunlight' ? selectedPlant.plant.sunlight_requirement : selectedPlant.plant.water_requirement;
        return current === req ? 'Ideal' : 'Suboptimal';
    };

    if (loading && myPlants.length === 0 && !editingPlant && !selectedPlant) return <div className="loading">Loading Simulation...</div>;

    if (selectedPlant) {
        return (
            <div className="inner-page-container">
                <div style={{marginBottom: '2rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center'}}>
                    <button className="btn-secondary" onClick={() => setSelectedPlant(null)}>
                        &larr; Back to My Garden
                    </button>
                    <button className="btn-cancel" style={{background: 'rgba(239, 68, 68, 0.2)', color: '#ef4444'}} onClick={() => removeUserPlant(selectedPlant.id)}>
                        Remove Plant
                    </button>
                </div>

                <div className="inner-grid">
                    <div className="inner-left glass-card">
                        <div className="inner-header">
                            <span className={`badge badge-${getConditionStatus('sunlight', selectedPlant.current_sunlight_level).toLowerCase()}`}>{selectedPlant.growth_stage} - {getConditionStatus('sunlight', selectedPlant.current_sunlight_level) === 'Ideal' && getConditionStatus('water', selectedPlant.current_water_level) === 'Ideal' ? 'Happy' : 'Stressed'}</span>
                            <span style={{color: 'var(--text-secondary)'}}>Day {selectedPlant.age_days}</span>
                        </div>
                        
                        <div className="inner-visualizer">
                            <PlantVisualizer growth={selectedPlant.growth_percentage} status={selectedPlant.health < 20 ? 'withered' : 'living'} />
                        </div>

                        <div className="inner-stats">
                            <div className="stat-row">
                                <div className="input-label">
                                    <span>Growth</span>
                                    <span>{Math.round(selectedPlant.growth_percentage)}%</span>
                                </div>
                                <div className="progress-bar-bg">
                                    <div className="progress-bar-fill" style={{width: `${selectedPlant.growth_percentage}%`}}></div>
                                </div>
                            </div>
                            <div className="stat-row" style={{marginTop: '1rem'}}>
                                <div className="input-label">
                                    <span>Health</span>
                                    <span>{selectedPlant.health}%</span>
                                </div>
                                <div className="progress-bar-bg">
                                    <div className="progress-bar-fill" style={{width: `${selectedPlant.health}%`, background: selectedPlant.health < 30 ? 'var(--danger)' : 'var(--success)'}}></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div className="inner-right glass-card">
                        <h3>Environmental Controls</h3>
                        <p style={{color: 'var(--text-secondary)', marginBottom: '2rem'}}>Match the <b>Target</b> requirements to recover health.</p>
                        
                        <div className="control-item">
                            <div className="input-label">
                                <span><Sun size={16} /> Sunlight (Target: <b style={{textTransform: 'capitalize'}}>{selectedPlant.plant.sunlight_requirement}</b>)</span>
                                <span className={getConditionStatus('sunlight', selectedPlant.current_sunlight_level) === 'Ideal' ? 'text-success' : 'text-warning'}>
                                    {selectedPlant.current_sunlight_level.toUpperCase()}
                                </span>
                            </div>
                            <input 
                                type="range" 
                                min="0" max="100" 
                                value={getLevelValue(selectedPlant.current_sunlight_level)} 
                                onChange={(e) => handleCareChange('sunlight', e.target.value)}
                            />
                            <div className="range-labels">
                                <span>Low</span>
                                <span>Medium</span>
                                <span>High</span>
                            </div>
                        </div>

                        <div className="control-item">
                            <div className="input-label">
                                <span><Droplets size={16} /> Water (Target: <b style={{textTransform: 'capitalize'}}>{selectedPlant.plant.water_requirement}</b>)</span>
                                <span className={getConditionStatus('water', selectedPlant.current_water_level) === 'Ideal' ? 'text-success' : 'text-warning'}>
                                    {selectedPlant.current_water_level.toUpperCase()}
                                </span>
                            </div>
                            <input 
                                type="range" 
                                min="0" max="100" 
                                value={getLevelValue(selectedPlant.current_water_level)} 
                                onChange={(e) => handleCareChange('water', e.target.value)}
                            />
                            <div className="range-labels">
                                <span>Low</span>
                                <span>Medium</span>
                                <span>High</span>
                            </div>
                        </div>

                        <div className="inner-actions">
                            <button className="btn-primary" onClick={triggerGrowth} disabled={loading} style={{flex: 1}}>
                                <Plus size={18} /> {loading ? 'Growing...' : 'Next Day'}
                            </button>
                            <button className="btn-secondary" style={{padding: '0.75rem'}} onClick={() => handleCareChange('water', 100)}>
                                Full Water
                            </button>
                            <button className="btn-secondary" style={{padding: '0.75rem'}} onClick={() => handleCareChange('sunlight', 100)}>
                                Max Sun
                            </button>
                        </div>
                    </div>

                    <div className="inner-bottom" style={{gridColumn: 'span 2'}}>
                        <StatsDashboard history={selectedPlant.history} />
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="simulator-container">
            {error && <div className="error-banner">{error}</div>}

            <section className="admin-section glass-card" style={{marginBottom: '3rem'}}>
                <div className="section-header" style={{marginBottom: '1rem'}}>
                    <div>
                        <h2 className="section-title"><Activity size={20} /> Master Plant Configuration</h2>
                        <p style={{color: 'var(--text-secondary)'}}>Configure base requirements and growth speed for plant species.</p>
                    </div>
                    <button className="btn-primary" onClick={() => setShowAddForm(!showAddForm)}>
                        {showAddForm ? 'Cancel' : '+ Add New Species'}
                    </button>
                </div>

                {showAddForm && (
                    <div className="add-plant-form glass-card" style={{background: 'rgba(255,255,255,0.05)', marginBottom: '2rem', padding: '1.5rem'}}>
                        <h3 style={{marginBottom: '1.5rem'}}>Define New Plant Species</h3>
                        <div className="form-grid" style={{display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))', gap: '1rem', marginBottom: '1.5rem'}}>
                            <div className="form-group">
                                <label>Plant Name</label>
                                <input type="text" placeholder="e.g. Bamboo" value={newPlantForm.name} onChange={e => setNewPlantForm({...newPlantForm, name: e.target.value})} />
                            </div>
                            <div className="form-group">
                                <label>Category</label>
                                <select value={newPlantForm.category} onChange={e => setNewPlantForm({...newPlantForm, category: e.target.value})}>
                                    <option value="small">Small (Fast)</option>
                                    <option value="medium">Medium</option>
                                    <option value="tree">Tree (Slow)</option>
                                </select>
                            </div>
                            <div className="form-group">
                                <label>Growth Days</label>
                                <input type="number" value={newPlantForm.base_growth_days} onChange={e => setNewPlantForm({...newPlantForm, base_growth_days: e.target.value})} />
                            </div>
                            <div className="form-group">
                                <label>Water Req.</label>
                                <select value={newPlantForm.water_requirement} onChange={e => setNewPlantForm({...newPlantForm, water_requirement: e.target.value})}>
                                    <option value="low">Low</option>
                                    <option value="medium">Medium</option>
                                    <option value="high">High</option>
                                </select>
                            </div>
                            <div className="form-group">
                                <label>Sun Req.</label>
                                <select value={newPlantForm.sunlight_requirement} onChange={e => setNewPlantForm({...newPlantForm, sunlight_requirement: e.target.value})}>
                                    <option value="low">Low</option>
                                    <option value="medium">Medium</option>
                                    <option value="high">High</option>
                                </select>
                            </div>
                        </div>
                        <button className="btn-primary" onClick={handleAddPlant} disabled={!newPlantForm.name}>Create Species</button>
                    </div>
                )}
                
                <div style={{overflowX: 'auto', marginBottom: '1rem'}}>
                    <table className="config-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Growth Days</th>
                                <th>Water Req.</th>
                                <th>Sun Req.</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {availablePlants.map(plant => (
                                <tr key={plant.id}>
                                    {editingPlant === plant.id ? (
                                        <>
                                            <td><input type="text" value={editForm.name} onChange={e => setEditForm({...editForm, name: e.target.value})} /></td>
                                            <td>
                                                <select value={editForm.category} onChange={e => setEditForm({...editForm, category: e.target.value})}>
                                                    <option value="small">Small</option>
                                                    <option value="medium">Medium</option>
                                                    <option value="tree">Tree</option>
                                                </select>
                                            </td>
                                            <td><input type="number" value={editForm.base_growth_days} onChange={e => setEditForm({...editForm, base_growth_days: e.target.value})} /></td>
                                            <td>
                                                <select value={editForm.water_requirement} onChange={e => setEditForm({...editForm, water_requirement: e.target.value})}>
                                                    <option value="low">Low</option>
                                                    <option value="medium">Medium</option>
                                                    <option value="high">High</option>
                                                </select>
                                            </td>
                                            <td>
                                                <select value={editForm.sunlight_requirement} onChange={e => setEditForm({...editForm, sunlight_requirement: e.target.value})}>
                                                    <option value="low">Low</option>
                                                    <option value="medium">Medium</option>
                                                    <option value="high">High</option>
                                                </select>
                                            </td>
                                            <td>
                                                <button onClick={handleUpdatePlant} className="btn-save">Save</button>
                                                <button onClick={() => setEditingPlant(null)} className="btn-cancel">Cancel</button>
                                            </td>
                                        </>
                                    ) : (
                                        <>
                                            <td>{plant.name}</td>
                                            <td><span className={`tag-${plant.category}`}>{plant.category}</span></td>
                                            <td>{plant.base_growth_days}</td>
                                            <td>{plant.water_requirement}</td>
                                            <td>{plant.sunlight_requirement}</td>
                                            <td>
                                                <button onClick={() => startEditing(plant)} className="btn-edit-config" style={{marginRight: '8px'}}>Edit</button>
                                                <button onClick={() => handleDeletePlant(plant.id)} className="btn-cancel" style={{background: 'rgba(239, 68, 68, 0.2)', color: '#ef4444'}}>Delete</button>
                                            </td>
                                        </>
                                    )}
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </section>

            <section className="selection-section">
                <h2 className="section-title">Select a New Plant</h2>
                <div className="plant-grid">
                    {availablePlants.map(plant => (
                        <div key={plant.id} className="plant-card glass-card">
                            <div className="plant-icon-wrapper">
                                <Leaf className={`icon-${plant.category}`} size={32} />
                            </div>
                            <h3>{plant.name}</h3>
                            <div className="plant-meta">
                                <span>{plant.category.toUpperCase()}</span>
                                <span>{plant.base_growth_days} Days</span>
                            </div>
                            <div className="requirements">
                                <div className="req-item">
                                    <Droplets size={14} /> {plant.water_requirement}
                                </div>
                                <div className="req-item">
                                    <Sun size={14} /> {plant.sunlight_requirement}
                                </div>
                            </div>
                            <button 
                                className="btn-select" 
                                onClick={() => selectPlant(plant.id)}
                                disabled={loading}
                            >
                                <Plus size={16} /> Plant
                            </button>
                        </div>
                    ))}
                </div>
            </section>

            <section className="my-plants-section">
                <div className="section-header">
                    <h2 className="section-title">My Garden</h2>
                </div>

                {myPlants.length === 0 ? (
                    <div className="empty-state glass-card">
                        <p>No plants in your garden yet. Select one above!</p>
                    </div>
                ) : (
                    <div className="my-plants-grid">
                        {myPlants.map(up => (
                            <div key={up.id} className="user-plant-card glass-card" style={{cursor: 'pointer', position: 'relative'}} onClick={() => setSelectedPlant(up)}>
                                <button 
                                    className="btn-delete-small" 
                                    style={{position: 'absolute', top: '10px', right: '10px', background: 'rgba(239, 68, 68, 0.2)', color: '#ef4444', border: 'none', borderRadius: '50%', width: '24px', height: '24px', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 10}}
                                    onClick={(e) => removeUserPlant(up.id, e)}
                                >
                                    &times;
                                </button>
                                <div className="up-header">
                                    <div>
                                        <h3>{up.plant.name}</h3>
                                        <span className="stage-badge">{up.growth_stage}</span>
                                    </div>
                                    <div className="health-stat" style={{color: up.health < 30 ? 'var(--danger)' : 'var(--success)'}}>
                                        <Activity size={14} /> {up.health}%
                                    </div>
                                </div>

                                <div className="visualizer-wrapper">
                                    <PlantVisualizer 
                                        growth={up.growth_percentage} 
                                        status={up.health < 20 ? 'withered' : 'living'} 
                                    />
                                </div>

                                <div className="growth-progress-container">
                                    <div className="progress-labels">
                                        <span>Growth Progress</span>
                                        <span>{Math.round(up.growth_percentage)}%</span>
                                    </div>
                                    <div className="progress-bar-bg">
                                        <div 
                                            className="progress-bar-fill" 
                                            style={{ width: `${up.growth_percentage}%` }}
                                        ></div>
                                    </div>
                                </div>

                                <div className="click-hint" style={{textAlign: 'center', fontSize: '0.7rem', color: 'var(--text-secondary)'}}>
                                    Click to Manage
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </section>
        </div>
    );
};

const Plus = ({size, style}) => (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={style}>
        <line x1="12" y1="5" x2="12" y2="19"></line>
        <line x1="5" y1="12" x2="19" y2="12"></line>
    </svg>
);

export default PlantSimulator;

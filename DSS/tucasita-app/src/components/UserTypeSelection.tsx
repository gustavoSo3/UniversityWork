'use client'

import React from 'react';

interface UserTypeSelectionProps {
  onUserTypeSelect: (type: 'Agent' | 'Buyer') => void;
}

const UserTypeSelection: React.FC<UserTypeSelectionProps> = ({ onUserTypeSelect }) => {
  return (
    <div className="space-y-4 flex flex-col items-center">
      <h2>Select User Type</h2>
      <button onClick={() => onUserTypeSelect('Agent')} className="bg-green-500 text-white px-4 py-2 rounded">Register as Agent</button>
      <button onClick={() => onUserTypeSelect('Buyer')} className="bg-blue-500 text-white px-4 py-2 rounded">Register as Buyer</button>
    </div>
  );
};

export default UserTypeSelection;


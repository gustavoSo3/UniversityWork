'use client'

import React, { useState } from 'react';

export interface UserFormData {
  fullName: string;
  email: string;
  phone: string;
  password: string;
  confirmPassword: string;
  address: string;
  agencyName?: string;
  areaOfOperation?: string;
}

interface Props {
  userType: 'Agent' | 'Buyer';
  userDetails: UserFormData;
  onSubmit: (data: UserFormData) => void;
  onDetailsChange: (data: UserFormData) => void;
}

const UserDetails: React.FC<Props> = ({ userType, userDetails, onSubmit, onDetailsChange }) => {

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const updatedData = { ...userDetails, [e.target.name]: e.target.value };

    onDetailsChange(updatedData);
  };

  return (
    <form onSubmit={(e) => { e.preventDefault(); onSubmit(userDetails); }} className="space-y-4 flex flex-col items-center">
      {/* Common fields */}
      <input
        type="text"
        name="fullName"
        placeholder="Full Name"
        value={userDetails.fullName}
        onChange={handleInputChange}
        className="p-2 border rounded w-full"
      />
      <input
        type="email"
        name="email"
        placeholder="Email Address"
        value={userDetails.email}
        onChange={handleInputChange}
        className="p-2 border rounded w-full"
      />
      <input
        type="tel"
        name="phone"
        placeholder="Phone Number"
        value={userDetails.phone}
        onChange={handleInputChange}
        className="p-2 border rounded w-full"
      />
      <input
        type="password"
        name="password"
        placeholder="Password"
        value={userDetails.password}
        onChange={handleInputChange}
        className="p-2 border rounded w-full"
      />
      <input
        type="password"
        name="confirmPassword"
        placeholder="Confirm Password"
        value={userDetails.confirmPassword}
        onChange={handleInputChange}
        className="p-2 border rounded w-full"
      />
      <input
        type="text"
        name="address"
        placeholder="Address"
        value={userDetails.address}
        onChange={handleInputChange}
        className="p-2 border rounded w-full"
      />

      {userType === 'Agent' && (
        <>
          <input
            type="text"
            name="agencyName"
            placeholder="Agency Name"
            value={userDetails.agencyName || ''}
            onChange={handleInputChange}
            className="p-2 border rounded w-full"
          />
          <input
            type="text"
            name="areaOfOperation"
            placeholder="Area of Operation"
            value={userDetails.areaOfOperation || ''}
            onChange={handleInputChange}
            className="p-2 border rounded w-full"
          />
        </>
      )}

      <button type="submit" className="bg-blue-500 text-white px-4 py-2 rounded">Submit</button>
    </form>
  );
};

export default UserDetails;

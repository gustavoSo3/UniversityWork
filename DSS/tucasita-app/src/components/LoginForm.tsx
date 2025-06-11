'use client'

import React, { useState } from 'react';

interface Props {
  onSubmit: (username: string, password: string) => void;
}

const LoginForm: React.FC<Props> = ({ onSubmit }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(username, password);
  };

  return (
    <form onSubmit={handleLogin}>
      <div className="flex flex-col items-center mt-20">
        <label className="text-lg mb-3" htmlFor="username">Username:</label>
        <input
          className="mb-6 p-3 text-base border rounded w-72"
          type="text"
          id="username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
      
        <label className="text-lg mb-3" htmlFor="password">Password:</label>
        <input
          className="mb-6 p-3 text-base border rounded w-72"
          type="password"
          id="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </div>
      <button className="py-2 px-8 text-lg bg-blue-500 text-white rounded cursor-pointer hover:bg-blue-700" type="submit">Login</button>
    </form>
  );
};

export default LoginForm;

import React from 'react';
import './Header.css';

const Header = () => {
  return (
    <header className="header">
      <div className="logo">
        <h1>Sales Management Tool</h1>
      </div>
      <nav className="nav">
        <ul>
          <li><a href="/">Dashboard</a></li>
          <li><a href="/customers">Customers</a></li>
          <li><a href="/reports">Reports</a></li>
          <li><a href="/settings">Settings</a></li>
        </ul>
      </nav>
    </header>
  );
};

export default Header;

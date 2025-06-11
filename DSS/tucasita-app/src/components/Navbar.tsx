import React from 'react';
import Link from 'next/link';
import styles from './Navbar.module.scss';

const Navbar: React.FC = () => {
  return (
    <div className={styles.navbar}>
      <Link href="/">
        <button className={styles.button}>Home</button>
      </Link>
      <Link href="/registration">
        <button className={styles.button}>Register</button>
      </Link>
      <Link href="/login">
        <button className={styles.button}>Login</button>
      </Link>
    </div>
  );
};

export default Navbar;

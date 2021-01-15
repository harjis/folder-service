import React from "react";

import styles from "./Loading.module.css";

type Props = {
  message: string;
};
export const Loading: React.FC<Props> = (props) => (
  <div className={styles.container}>Loading {props.message}...</div>
);

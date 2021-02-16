import React from "react";

type Props = {
  value: string;
  onChange: (value: string) => void;
};
export const Input: React.FC<Props> = (props) => {
  return (
    <input
      type="text"
      value={props.value}
      onChange={(event) => {
        const value = event.currentTarget.value;
        props.onChange(value);
      }}
    />
  );
};

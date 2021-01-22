import { AuthStore } from "../stores/AuthStore";

export const url = `${window.location.origin}/api`;

export const options = (
  options: Record<string, any> = {}
): Record<string, any> => ({
  ...options,
  headers: {
    "Content-Type": "application/json",
    authorization: `Bearer ${AuthStore.getAccessToken()}`,
  },
});

let accessToken: string | null = null;

export const AuthStore = {
  setAccessToken: (token: string): void => {
    accessToken = token;
  },

  getAccessToken: (): string | null => {
    return accessToken;
  },
};

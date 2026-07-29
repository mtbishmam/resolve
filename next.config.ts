import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  reactStrictMode: true,
  images: {
    remotePatterns: [
      { protocol: "https", hostname: "codeforces.com" },
      { protocol: "https", hostname: "cses.fi" },
    ],
  },
};

export default nextConfig;

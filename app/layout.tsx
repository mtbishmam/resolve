import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import { headers } from "next/headers";
import "katex/dist/katex.min.css";
import identity from "@/identity.json";
import "./globals.css";

const geist = Geist({ variable: "--font-geist", subsets: ["latin"] });
const mono = Geist_Mono({ variable: "--font-mono", subsets: ["latin"] });

export async function generateMetadata(): Promise<Metadata> {
  const requestHeaders = await headers();
  const host =
    requestHeaders.get("x-forwarded-host") ??
    requestHeaders.get("host") ??
    "localhost:3000";
  const protocol =
    requestHeaders.get("x-forwarded-proto") ??
    (host.startsWith("localhost") ? "http" : "https");
  const base = new URL(`${protocol}://${host}`);
  const title = "ReSolve — Competitive programming recall";
  const description =
    "A private, speed-first competitive-programming reflection and active-recall system.";
  const image = new URL("/og.png", base).toString();
  return {
    metadataBase: base,
    title,
    description,
    alternates: {
      canonical: identity.productionUrl,
    },
    openGraph: {
      title,
      description,
      type: "website",
      images: [{ url: image, width: 1731, height: 909, alt: "ReSolve" }],
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: [image],
    },
  };
}

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body className={`${geist.variable} ${mono.variable}`}>{children}</body>
    </html>
  );
}

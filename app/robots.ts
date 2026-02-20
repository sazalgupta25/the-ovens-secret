import { MetadataRoute } from 'next';

export default function robots(): MetadataRoute.Robots {
  return {
    rules: [
      {
        userAgent: '*',
        allow: '/',
        disallow: ['/admin', '/.next', '/api'],
      },
      {
        userAgent: 'Googlebot',
        allow: '/',
        crawlDelay: 0,
      },
    ],
    sitemap: `${process.env.NEXT_PUBLIC_BASE_URL || 'https://theovenssecret.com'}/sitemap.xml`,
    host: process.env.NEXT_PUBLIC_BASE_URL || 'https://theovenssecret.com',
  };
}

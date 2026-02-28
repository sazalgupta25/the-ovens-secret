import Link from "next/link";
import { ReactNode } from "react";

interface NavLinkProps {
  href: string;
  children: ReactNode;
  isActive?: boolean;
  className?: string;
}

export function NavLink({ href, children, isActive = false, className = "" }: NavLinkProps) {
  const baseStyles = "transition duration-200";
  const activeStyles = isActive ? "text-amber-200 border-b-2 border-amber-200" : "hover:text-amber-200";

  return (
    <Link href={href} className={`${baseStyles} ${activeStyles} ${className}`}>
      {children}
    </Link>
  );
}

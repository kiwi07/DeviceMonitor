/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina - www.xs-labs.com
 * Distributed under the Boost Software License, Version 1.0.
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * 
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      ...
 * @copyright   (c) 2012 - Jean-David Gadina - www.xs-labs.com
 * @abstract    ...
 */

#import "DMPreferences.h"

NSString * const DMPreferencesKeyActiveDisk = @"ActiveDisk";
NSString * const DMPreferencesKeyActivePath = @"ActivePath";

static DMPreferences * __sharedInstance = nil;

@implementation DMPreferences

+ ( DMPreferences * )sharedInstance
{
    @synchronized( self )
    {
        if( __sharedInstance == nil )
        {
            __sharedInstance = [ [ super allocWithZone: NULL ] init ];
        }
    }

    return __sharedInstance;
}

+ ( id )allocWithZone:( NSZone * )zone
{
    ( void )zone;

    @synchronized( self )
    {
        return [ [ self sharedInstance ] retain ];
    }
}

- ( id )copyWithZone:( NSZone * )zone
{
    ( void )zone;

    return self;
}

- ( id )retain
{
    return self;
}

- ( NSUInteger )retainCount
{
    return UINT_MAX;
}

- ( oneway void )release
{}

- ( id )autorelease
{
    return self;
}

- ( NSString * )activeDisk
{
    @synchronized( self )
    {
        return [ [ NSUserDefaults standardUserDefaults ] objectForKey: DMPreferencesKeyActiveDisk ];
    }
}

- ( NSString * )activePath
{
    @synchronized( self )
    {
        return [ [ NSUserDefaults standardUserDefaults ] objectForKey: DMPreferencesKeyActivePath ];
    }
}

- ( void )setActiveDisk: ( NSString * )value
{
    @synchronized( self )
    {
        [ [ NSUserDefaults standardUserDefaults ] setObject: value forKey: DMPreferencesKeyActiveDisk ];
        [ [ NSUserDefaults standardUserDefaults ] synchronize ];
    }
}

- ( void )setActivePath: ( NSString * )value
{
    @synchronized( self )
    {
        [ [ NSUserDefaults standardUserDefaults ] setObject: value forKey: DMPreferencesKeyActivePath ];
        [ [ NSUserDefaults standardUserDefaults ] synchronize ];
    }
}

@end

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
 * @file        ...
 * @copyright   (c) 2012 - Jean-David Gadina - www.xs-labs.com
 * @abstract    ...
 */

#import "UIDevice+DM.h"

#include <mach/mach.h> 
#include <mach/mach_host.h>

static uint64_t __memoryActiveBytes;
static uint64_t __memoryInactiveBytes;
static uint64_t __memoryWiredBytes;
static uint64_t __memoryFreeBytes;
static uint64_t __memoryUsedBytes;
static uint64_t __memoryTotalBytes;
static uint64_t __memoryPageSize;

@interface UIDevice( DM_Private )

- ( void )updateMemoryInformations;

@end

@implementation UIDevice( DM_Private )

- ( void )updateMemoryInformations
{
    @synchronized( self )
    {
        mach_port_t             hostPort;
        mach_msg_type_number_t  hostSize;
        vm_size_t               pageSize;
        vm_statistics_data_t    vmStat;
        
        hostPort = mach_host_self();
        hostSize = sizeof( vm_statistics_data_t ) / sizeof( integer_t );
        
        host_page_size( hostPort, &pageSize );
        
        if( host_statistics( hostPort, HOST_VM_INFO, ( host_info_t )&vmStat, &hostSize ) != KERN_SUCCESS )
        {
            return;
        }
        
        __memoryPageSize        = pageSize;
        __memoryActiveBytes     = vmStat.active_count   * __memoryPageSize;
        __memoryInactiveBytes   = vmStat.inactive_count * __memoryPageSize;
        __memoryWiredBytes      = vmStat.wire_count     * __memoryPageSize;
        __memoryFreeBytes       = vmStat.free_count     * __memoryPageSize;
        __memoryUsedBytes       = __memoryActiveBytes + __memoryInactiveBytes + __memoryWiredBytes;
        __memoryTotalBytes      = __memoryUsedBytes + __memoryFreeBytes;
    }
}

@end

@implementation UIDevice( DM )

- ( uint64_t )activeMemory
{
    [ self updateMemoryInformations ];
    
    return __memoryActiveBytes;
}

- ( uint64_t )inactiveMemory
{
    [ self updateMemoryInformations ];
    
    return __memoryInactiveBytes;
}

- ( uint64_t )wiredMemory
{
    [ self updateMemoryInformations ];
    
    return __memoryWiredBytes;
}

- ( uint64_t )freeMemory
{
    [ self updateMemoryInformations ];
    
    return __memoryFreeBytes;
}

- ( uint64_t )usedMemory
{
    [ self updateMemoryInformations ];
    
    return __memoryUsedBytes;
}

- ( uint64_t )totalMemory
{
    [ self updateMemoryInformations ];
    
    return __memoryTotalBytes;
}

@end

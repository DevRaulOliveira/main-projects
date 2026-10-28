import asyncio
import httpx
import aiohttp

async def call_azure_resource():
    async with httpx.AsyncClient() as client:
        response = await client.get('https://genie-space-web-app.azurewebsites.net')
        return response.json()